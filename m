From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC PATCH 1/2] irq: Add a framework to measure interrupt timings
Date: Wed,  6 Jan 2016 16:22:53 +0100
Message-ID: <1452093774-17831-2-git-send-email-daniel.lezcano@linaro.org>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36531 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbcAFPXO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 10:23:14 -0500
Received: by mail-wm0-f48.google.com with SMTP id l65so63167582wmf.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2016 07:23:13 -0800 (PST)
In-Reply-To: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

The interrupt framework gives a lot of information and statistics about
each interrupt.

Unfortunately there is no way to measure when interrupts occur and provide
a mathematical model for their behavior which could help in predicting
their next occurence.

This framework allows for registering a callback function that is invoked
when an interrupt occurs.

Each time, the callback will be called with the timestamp corresponding to
when happened the interrupt.

This framework allows a subsystem to register a handler in order to receive
the timing information for the registered interrupt. That gives other
subsystems the ability to compute predictions for the next interrupt occurence.

The main objective is to track and detect the periodic interrupts in order
to predict the next event on a cpu and anticipate the sleeping time when
entering idle. This fine grain approach allows to simplify and rationalize
a wake up event prediction without IPIs interference, thus letting the
scheduler to be smarter with the wakeup IPIs regarding the idle period.

The irq timings tracking showed, in the proof-of-concept, an improvement with
the predictions, the approach is correct but my knowledge to the irq
subsystem is limited. I am not sure this patch measuring irq time interval
is correct or acceptable, so it is at the RFC state (minus some polishing).

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/interrupt.h | 45 ++++++++++++++++++++++++++++++++
 include/linux/irqdesc.h   |  3 +++
 kernel/irq/Kconfig        |  4 +++
 kernel/irq/handle.c       | 12 +++++++++
 kernel/irq/manage.c       | 65 ++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index be7e75c..f48e8ff 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -123,6 +123,51 @@ struct irqaction {
 
 extern irqreturn_t no_action(int cpl, void *dev_id);
 
+#ifdef CONFIG_IRQ_TIMINGS
+/**
+ * timing handler to be called when an interrupt happens
+ */
+typedef void (*irqt_handler_t)(unsigned int, ktime_t, void *, void *);
+
+/**
+ * struct irqtimings - per interrupt irq timings descriptor
+ * @handler:   interrupt handler timings function
+ * @data:      pointer to the private data to be passed to the handler
+ * @timestamp: latest interruption occurence
+ */
+struct irqtimings {
+	irqt_handler_t	  handler;
+	void              *data;
+} ____cacheline_internodealigned_in_smp;
+
+/**
+ * struct irqt_ops - structure to be used by the subsystem to call the
+ * register and unregister ops when an irq is setup or freed.
+ * @setup: registering callback
+ * @free: unregistering callback
+ *
+ * The callbacks assumes the lock is held on the irq desc
+ */
+struct irqtimings_ops {
+	int (*setup)(unsigned int, struct irqaction *);
+	void (*free)(unsigned int, void *);
+};
+
+extern int register_irq_timings(struct irqtimings_ops *ops);
+extern int setup_irq_timings(unsigned int irq, struct irqaction *act);
+extern void free_irq_timings(unsigned int irq, void *dev_id);
+#else
+static inline int setup_irq_timings(unsigned int irq, struct irqaction *act)
+{
+	return 0;
+}
+
+static inline void free_irq_timings(unsigned int irq, void *dev_id)
+{
+	;
+}
+#endif
+
 extern int __must_check
 request_threaded_irq(unsigned int irq, irq_handler_t handler,
 		     irq_handler_t thread_fn,
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index a587a33..e0d4263 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -51,6 +51,9 @@ struct irq_desc {
 #ifdef CONFIG_IRQ_PREFLOW_FASTEOI
 	irq_preflow_handler_t	preflow_handler;
 #endif
+#ifdef CONFIG_IRQ_TIMINGS
+	struct irqtimings       *timings;
+#endif
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
 	unsigned int		core_internal_state__do_not_mess_with_it;
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 9a76e3b..1275fd1 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -73,6 +73,10 @@ config GENERIC_MSI_IRQ_DOMAIN
 config HANDLE_DOMAIN_IRQ
 	bool
 
+config IRQ_TIMINGS
+        bool
+	default y
+
 config IRQ_DOMAIN_DEBUG
 	bool "Expose hardware/virtual IRQ mapping via debugfs"
 	depends on IRQ_DOMAIN && DEBUG_FS
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index e25a83b..ca8b0c5 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -132,6 +132,17 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
+#ifdef CONFIG_IRQ_TIMINGS
+void handle_irqt_event(struct irqtimings *irqt, struct irqaction *action)
+{
+	if (irqt)
+		irqt->handler(action->irq, ktime_get(),
+			      action->dev_id, irqt->data);
+}
+#else
+#define handle_irqt_event(a, b)
+#endif
+
 irqreturn_t
 handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
 {
@@ -165,6 +176,7 @@ handle_irq_event_percpu(struct irq_desc *desc, struct irqaction *action)
 			/* Fall through to add to randomness */
 		case IRQ_HANDLED:
 			flags |= action->flags;
+			handle_irqt_event(desc->timings, action);
 			break;
 
 		default:
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f9a59f6..21cc7bf 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1017,6 +1017,60 @@ static void irq_release_resources(struct irq_desc *desc)
 		c->irq_release_resources(d);
 }
 
+#ifdef CONFIG_IRQ_TIMINGS
+/*
+ * Global variable, only used by accessor functions, currently only
+ * one user is allowed and it is up to the caller to make sure to
+ * setup the irq timings which are already setup.
+ */
+static struct irqtimings_ops *irqtimings_ops;
+
+/**
+ * register_irq_timings - register the ops when an irq is setup or freed
+ *
+ * @ops: the register/unregister ops to be called when at setup or
+ * free time
+ *
+ * Returns -EBUSY if the slot is already in use, zero on success.
+ */
+int register_irq_timings(struct irqtimings_ops *ops)
+{
+	if (irqtimings_ops)
+		return -EBUSY;
+
+	irqtimings_ops = ops;
+
+	return 0;
+}
+
+/**
+ * setup_irq_timings - call the timing register callback
+ *
+ * @desc: an irq desc structure
+ *
+ * Returns -EINVAL in case of error, zero on success.
+ */
+int setup_irq_timings(unsigned int irq, struct irqaction *act)
+{
+	if (irqtimings_ops && irqtimings_ops->setup)
+		return irqtimings_ops->setup(irq, act);
+	return 0;
+}
+
+/**
+ * free_irq_timings - call the timing unregister callback
+ *
+ * @irq: the interrupt number
+ * @dev_id: the device id
+ *
+ */
+void free_irq_timings(unsigned int irq, void *dev_id)
+{
+	if (irqtimings_ops && irqtimings_ops->free)
+		irqtimings_ops->free(irq, dev_id);
+}
+#endif /* CONFIG_IRQ_TIMINGS */
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1037,6 +1091,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
 
+	ret = setup_irq_timings(irq, new);
+	if (ret)
+		goto out_mput;
 	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
@@ -1045,7 +1102,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (nested) {
 		if (!new->thread_fn) {
 			ret = -EINVAL;
-			goto out_mput;
+			goto out_free_timings;
 		}
 		/*
 		 * Replace the primary handler which was provided from
@@ -1323,6 +1380,10 @@ out_thread:
 		kthread_stop(t);
 		put_task_struct(t);
 	}
+
+out_free_timings:
+	free_irq_timings(irq, new->dev_id);
+
 out_mput:
 	module_put(desc->owner);
 	return ret;
@@ -1408,6 +1469,8 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 
 	unregister_handler_proc(irq, action);
 
+	free_irq_timings(irq, dev_id);
+
 	/* Make sure it's not being used on another CPU: */
 	synchronize_irq(irq);
 
-- 
1.9.1

