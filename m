From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Wed, 20 Jan 2016 17:00:32 +0100
Message-ID: <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
References: <alpine.DEB.2.11.1601201634520.3575@nanos>
 <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

The interrupt framework gives a lot of information and statistics about
each interrupt.

Unfortunately there is no way to measure when interrupts occur and provide
a mathematical model for their behavior which could help in predicting
their next occurence.

This framework allows for registering a callback function that is invoked
when an interrupt occurs. Each time, the callback will be called with the
timestamp.

The main objective is to track and detect the periodic interrupts in order
to predict the next event on a cpu and anticipate the sleeping time when
entering idle. This fine grain approach allows to simplify and rationalize
a wake up event prediction without IPIs interference, thus letting the
scheduler to be smarter with the wakeup IPIs regarding the idle period.

The irq timing feature must be enabled by the subsytem at compile time and
this one must use the DECLARE_IRQ_TIMINGS(ops) macro in order to declare
the ops to be used. Without this, the kernel will fail to compile with an
unresolved symbol. That is the guarantee the irq timings is not enabled
for nothing and will be used if it is defined in the config file.

Moreover, using a global ops variable, encapsulated in the irq code via the
DECLARE_IRQ_TIMINGS macro, allows to have the ops to be called at init
time, before the interrupts are setup. That prevents to introduce complex
code to update the subsystem's irq tracking table *after* the irqs init
happened.

The ops are as the following:
 - alloc   : called when an irqdesc is allocated
 - free    : called when an irqdesc is freed
 - setup   : called when an irq is registered with the irq handler
 - remove  : called when an irq is removed
 - handler : called when an irq was handled

A static key will be introduced when the irq prediction is switched on at
runtime in order to reduce an overhead near to zero when the kernel is not
using it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/interrupt.h  | 26 ++++++++++++++++++++++++++
 include/linux/irqhandler.h |  1 +
 kernel/irq/Kconfig         |  4 ++++
 kernel/irq/handle.c        |  1 +
 kernel/irq/internals.h     | 43 +++++++++++++++++++++++++++++++++++++++++++
 kernel/irq/irqdesc.c       |  6 ++++++
 kernel/irq/manage.c        | 10 +++++++++-
 7 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ad16809..f7ff6fe 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -123,6 +123,32 @@ struct irqaction {
 	struct proc_dir_entry	*dir;
 } ____cacheline_internodealigned_in_smp;
 
+#ifdef CONFIG_IRQ_TIMINGS
+/**
+ * struct irqt_ops - structure to be used by the subsystem to track
+ *                   irq timings
+ * @alloc:    called when an irqdesc is allocated
+ * @free:     called when an irqdesc is free
+ * @setup:    called when an irq is setup, this is called under lock
+ * @remove:   called when an irq is removed
+ * @handler:  called when an interrupt is handled
+ */
+struct irqtimings_ops {
+	int (*alloc)(unsigned int);
+	void (*free)(unsigned int);
+	int (*setup)(unsigned int, struct irqaction *act);
+	void (*remove)(unsigned int, void *dev_id);
+	irqt_handler_t handler;
+};
+
+/**
+ * This macro *must* be used by the subsystem interested by the irq
+ * timing information.
+ */
+#define DECLARE_IRQ_TIMINGS(__ops)				\
+	const struct irqtimings_ops *__irqtimings = __ops;
+#endif
+
 extern irqreturn_t no_action(int cpl, void *dev_id);
 
 extern int __must_check
diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index 661bed0..4c1c77e 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -10,5 +10,6 @@ struct irq_desc;
 struct irq_data;
 typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
 typedef	void (*irq_preflow_handler_t)(struct irq_data *data);
+typedef	void (*irqt_handler_t)(unsigned int, ktime_t, void *);
 
 #endif
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 3b48dab..3f68619 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -77,6 +77,10 @@ config GENERIC_MSI_IRQ_DOMAIN
 config HANDLE_DOMAIN_IRQ
 	bool
 
+config IRQ_TIMINGS
+        bool
+	default n
+
 config IRQ_DOMAIN_DEBUG
 	bool "Expose hardware/virtual IRQ mapping via debugfs"
 	depends on IRQ_DOMAIN && DEBUG_FS
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index a302cf9..cfc76fd 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -165,6 +165,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 			/* Fall through to add to randomness */
 		case IRQ_HANDLED:
 			flags |= action->flags;
+			handle_irqtiming(irq, action->dev_id);
 			break;
 
 		default:
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fcab63c..cd4f61a 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -20,6 +20,49 @@ extern bool noirqdebug;
 
 extern struct irqaction chained_action;
 
+#ifdef CONFIG_IRQ_TIMINGS
+
+extern const struct irqtimings_ops *__irqtimings;
+
+static inline int alloc_irqtiming(unsigned int irq)
+{
+	if (__irqtimings->alloc)
+		return __irqtimings->alloc(irq);
+	return 0;
+}
+
+static inline void free_irqtiming(unsigned int irq)
+{
+	if (__irqtimings->free)
+		__irqtimings->free(irq);
+}
+
+static inline int setup_irqtiming(unsigned int irq, struct irqaction *act)
+{
+	if (__irqtimings->setup)
+		return __irqtimings->setup(irq, act);
+	return 0;
+}
+
+static inline void remove_irqtiming(unsigned int irq, void *dev_id)
+{
+	if (__irqtimings->remove)
+		__irqtimings->remove(irq, dev_id);
+}
+
+static inline void handle_irqtiming(unsigned int irq, void *dev_id)
+{
+	if (__irqtimings->handler)
+		__irqtimings->handler(irq, ktime_get(), dev_id);
+}
+#else
+static inline int alloc_irqtiming(unsigned int irq) { return 0; }
+static inline int setup_irqtiming(unsigned int irq, void *dev_id) { return 0; }
+static inline void free_irqtiming(unsigned int irq) {}
+static inline void remove_irqtiming(unsigned int irq, void *dev_id) { }
+static inline void handle_irqtiming(unsigned int irq, void *dev_id) { }
+#endif
+
 /*
  * Bits used by threaded handlers:
  * IRQTF_RUNTHREAD - signals that the interrupt handler thread should run
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 239e2ae..dc52f3a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -157,6 +157,9 @@ static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
 	if (alloc_masks(desc, gfp, node))
 		goto err_kstat;
 
+	if (alloc_irqtiming(irq))
+		goto err_mask;
+
 	raw_spin_lock_init(&desc->lock);
 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
 
@@ -164,6 +167,8 @@ static struct irq_desc *alloc_desc(int irq, int node, struct module *owner)
 
 	return desc;
 
+err_mask:
+	free_masks(desc);
 err_kstat:
 	free_percpu(desc->kstat_irqs);
 err_desc:
@@ -187,6 +192,7 @@ static void free_desc(unsigned int irq)
 	delete_irq_desc(irq);
 	mutex_unlock(&sparse_irq_lock);
 
+	free_irqtiming(irq);
 	free_masks(desc);
 	free_percpu(desc->kstat_irqs);
 	kfree(desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 6ead200..df1cdb6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1282,13 +1282,17 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 		init_waitqueue_head(&desc->wait_for_threads);
 
+		ret = setup_irqtiming(irq, new);
+		if (ret)
+			goto out_mask;
+
 		/* Setup the type (level, edge polarity) if configured: */
 		if (new->flags & IRQF_TRIGGER_MASK) {
 			ret = __irq_set_trigger(desc,
 						new->flags & IRQF_TRIGGER_MASK);
 
 			if (ret)
-				goto out_mask;
+				goto out_irqtiming;
 		}
 
 		desc->istate &= ~(IRQS_AUTODETECT | IRQS_SPURIOUS_DISABLED | \
@@ -1373,6 +1377,8 @@ mismatch:
 	}
 	ret = -EBUSY;
 
+out_irqtiming:
+	remove_irqtiming(irq, new->dev_id);
 out_mask:
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	free_cpumask_var(mask);
@@ -1483,6 +1489,8 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 	/* Make sure it's not being used on another CPU: */
 	synchronize_irq(irq);
 
+	remove_irqtiming(irq, dev_id);
+
 #ifdef CONFIG_DEBUG_SHIRQ
 	/*
 	 * It's a shared IRQ -- the driver ought to be prepared for an IRQ
-- 
1.9.1
