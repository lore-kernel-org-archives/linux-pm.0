From: david singleton <dsingleton@mvista.com>
Subject: Powerop-core.patch
Date: Mon, 31 Jul 2006 17:40:39 -0700
Message-ID: <da2bee3d44caaa234d884aa5ac28040f@mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

Here is the powerop-core patch that adds the concept of an operating =

point to the traditional
powermanagement code.  It also cenverts the character array  of suspend =

operating points to
power_op operating points and links them together to export to the user =

through /sys/power/supported_states.

A new routine is added to transition operating points that can scale =

either frequency or voltage of
the system.   Most operating points of CPUFREQ and SourceForge's =

Dynamic Power Management
are concerned with frequency and voltage operating points.

David

Signed-Off-by: David Singleton dsingleton@mvista.com

  Documentation/power/powerop.txt |  168 =

+++++++++++++++++++++++++++++++++++
  include/linux/pm.h              |   26 +++++
  kernel/power/main.c             |  189 =

+++++++++++++++++++++++++++++++---------
  kernel/power/power.h            |    2
  4 files changed, 341 insertions(+), 44 deletions(-)

Index: linux-2.6.17/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/kernel/power/main.c
+++ linux-2.6.17/kernel/power/main.c
@@ -49,7 +49,7 @@ void pm_set_ops(struct pm_ops * ops)
   *     the platform can enter the requested state.
   */

-static int suspend_prepare(suspend_state_t state)
+static int suspend_prepare(struct power_op * state)
  {
         int error =3D 0;
         unsigned int free_pages;
@@ -82,7 +82,7 @@ static int suspend_prepare(suspend_state
         }

         if (pm_ops->prepare) {
-               if ((error =3D pm_ops->prepare(state)))
+               if ((error =3D pm_ops->prepare(state->type)))
                         goto Thaw;
         }

@@ -94,7 +94,7 @@ static int suspend_prepare(suspend_state
         return 0;
   Finish:
         if (pm_ops->finish)
-               pm_ops->finish(state);
+               pm_ops->finish(state->type);
   Thaw:
         thaw_processes();
   Enable_cpu:
@@ -104,7 +104,7 @@ static int suspend_prepare(suspend_state
  }


-int suspend_enter(suspend_state_t state)
+int suspend_enter(struct power_op * state)
  {
         int error =3D 0;
         unsigned long flags;
@@ -115,7 +115,7 @@ int suspend_enter(suspend_state_t state)
                 printk(KERN_ERR "Some devices failed to power down\n");
                 goto Done;
         }
-       error =3D pm_ops->enter(state);
+       error =3D pm_ops->enter(state->type);
         device_power_up();
   Done:
         local_irq_restore(flags);
@@ -131,36 +131,94 @@ int suspend_enter(suspend_state_t state)
   *     console that we've allocated. This is not called for =

suspend-to-disk.
   */

-static void suspend_finish(suspend_state_t state)
+static void suspend_finish(struct power_op * state)
  {
         device_resume();
         resume_console();
         thaw_processes();
         enable_nonboot_cpus();
         if (pm_ops && pm_ops->finish)
-               pm_ops->finish(state);
+               pm_ops->finish(state->type);
         pm_restore_console();
  }


+struct power_op *current_state;
+struct power_op pm_states =3D {
+       .name =3D "default",
+       .type =3D PM_SUSPEND_ON,
+};

-
-static const char * const pm_states[PM_SUSPEND_MAX] =3D {
-       [PM_SUSPEND_STANDBY]    =3D "standby",
-       [PM_SUSPEND_MEM]        =3D "mem",
+static struct power_op standby =3D {
+       .name =3D "standby",
+       .description =3D "Power-On Suspend ACPI State: S1",
+       .type =3D PM_SUSPEND_STANDBY,
+};
+static struct power_op mem =3D {
+       .name =3D "mem   ",
+       .description =3D "Suspend-to-RAM ACPI State: S3",
+       .type =3D PM_SUSPEND_MEM,
+};
  #ifdef CONFIG_SOFTWARE_SUSPEND
-       [PM_SUSPEND_DISK]       =3D "disk",
-#endif
+static struct power_op disk =3D {
+       .name =3D "disk  ",
+       .description =3D "Suspend-to-disk ACPI State: S4",
+       .type =3D PM_SUSPEND_DISK,
  };
+#endif

-static inline int valid_state(suspend_state_t state)
+/*
+ *
+ */
+static int pm_change_state(struct power_op *state)
+{
+       int error =3D -EINVAL;
+       int len =3D strlen(state->name);
+       struct power_op *this, *next;
+       struct list_head *head =3D &pm_states.list;
+
+       /*
+        * list_find new operating point.
+        * compare to current operating point.
+        * if different change to new operating point.
+        */
+       list_for_each_entry_safe(this, next, head, list) {
+               if (strncmp(state->name, this->name, len) =3D=3D 0) {
+                       if ((strcmp(current_state->name, this->name)) =

=3D=3D 0) {
+                               return 0;
+                       }
+
+                       if (this->prepare_transition(current_state, =

this)) {
+                               break;
+                       }
+
+                       if (this->transition(current_state, this)) {
+                               break;
+                       }
+
+                       /*
+                        * now lets wait for the transition latency
+                        */
+                       udelay(this->latency);
+
+                       error =3D this->finish_transition(current_state, =

this);
+
+                       if (error =3D=3D 0)
+                               current_state =3D this;
+                       break;
+               }
+       }
+       return error;
+}
+
+static inline int valid_state(struct power_op * state)
  {
         /* Suspend-to-disk does not really need low-level support.
          * It can work with reboot if needed. */
-       if (state =3D=3D PM_SUSPEND_DISK)
+       if (state->type =3D=3D PM_SUSPEND_DISK)
                 return 1;

-       if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
+       if (pm_ops && pm_ops->valid && !pm_ops->valid(state->type))
                 return 0;
         return 1;
  }
@@ -168,7 +226,7 @@ static inline int valid_state(suspend_st

  /**
   *     enter_state - Do common work of entering low-power state.
- *     @state:         pm_state structure for state we're entering.
+ *     @state:         power_op structure for state we're entering.
   *
   *     Make sure we're the only ones trying to enter a sleep state. =

Fail
   *     if someone has beat us to it, since we don't want anything =

weird to
@@ -177,7 +235,7 @@ static inline int valid_state(suspend_st
   *     we've woken up).
   */

-static int enter_state(suspend_state_t state)
+static int enter_state(struct power_op *state)
  {
         int error;

@@ -186,16 +244,21 @@ static int enter_state(suspend_state_t s
         if (down_trylock(&pm_sem))
                 return -EBUSY;

-       if (state =3D=3D PM_SUSPEND_DISK) {
+       if (state->type =3D=3D PM_SUSPEND_DISK) {
                 error =3D pm_suspend_disk();
                 goto Unlock;
         }

-       pr_debug("PM: Preparing system for %s sleep\n", =

pm_states[state]);
+       if (state->type =3D=3D PM_FREQ_CHANGE) {
+               error =3D pm_change_state(state);
+               goto Unlock;
+       }
+
+       pr_debug("PM: Preparing system for %s sleep\n", state->name);
         if ((error =3D suspend_prepare(state)))
                 goto Unlock;

-       pr_debug("PM: Entering %s sleep\n", pm_states[state]);
+       pr_debug("PM: Entering %s sleep\n", state->name);
         error =3D suspend_enter(state);

         pr_debug("PM: Finishing wakeup.\n");
@@ -211,7 +274,15 @@ static int enter_state(suspend_state_t s
   */
  int software_suspend(void)
  {
-       return enter_state(PM_SUSPEND_DISK);
+       struct power_op *this, *next;
+       struct list_head *head =3D &pm_states.list;
+       int error =3D 0;
+
+       list_for_each_entry_safe(this, next, head, list) {
+               if (this->type =3D=3D PM_SUSPEND_DISK)
+                       error=3D enter_state(this);
+       }
+       return error;
  }


@@ -223,16 +294,48 @@ int software_suspend(void)
   *     structure, and enter (above).
   */

-int pm_suspend(suspend_state_t state)
+int pm_suspend(struct power_op * state)
  {
-       if (state > PM_SUSPEND_ON && state <=3D PM_SUSPEND_MAX)
+       if (state->type > PM_SUSPEND_ON && state->type <=3D =

PM_SUSPEND_MAX)
                 return enter_state(state);
         return -EINVAL;
  }

+decl_subsys(power,NULL,NULL);

+/**
+ *     supported_states - control system power state.
+ *
+ *     show() returns what states are supported, which are no longer
+ *     hard-coded to just 'standby' (Power-On Suspend), 'mem' =

(Suspend-to-RAM),
+ *     and *'disk' (Suspend-to-Disk), but show all the power states.
+ *
+ *     store() unwritable
+ */

-decl_subsys(power,NULL,NULL);
+static ssize_t supported_states_show(struct subsystem * subsys, char * =

buf)
+{
+       struct power_op *this, *next;
+       struct list_head *head =3D &pm_states.list;
+       const char *header =3D  "< Name >    <Frequency>  <Voltage>  =

<Transition L
atency>  < Description >\n";
+       char * s =3D buf;
+
+       s +=3D sprintf(s, "%s", header);
+       list_for_each_entry_safe(this, next, head, list) {
+               s +=3D sprintf(s,"%s %dKHz %dmV %dus %s\n", this->name,
+                  this->frequency, this->voltage, this->latency,
+                  this->description);
+       }
+
+       return (s - buf);
+}
+
+static ssize_t supported_states_store(struct subsystem * subsys, const =

char *bu
f, size_t n)
+{
+       return -EINVAL;
+}
+
+power_attr(supported_states);


  /**
@@ -248,36 +351,28 @@ decl_subsys(power,NULL,NULL);

  static ssize_t state_show(struct subsystem * subsys, char * buf)
  {
-       int i;
         char * s =3D buf;

-       for (i =3D 0; i < PM_SUSPEND_MAX; i++) {
-               if (pm_states[i] && valid_state(i))
-                       s +=3D sprintf(s,"%s ", pm_states[i]);
-       }
-       s +=3D sprintf(s,"\n");
+       s +=3D sprintf(s,"%s\n", current_state->name);
         return (s - buf);
  }

  static ssize_t state_store(struct subsystem * subsys, const char * =

buf, size_t
n)
  {
-       suspend_state_t state =3D PM_SUSPEND_STANDBY;
-       const char * const *s;
+       struct power_op *this, *next;
+       struct list_head *head =3D &pm_states.list;
         char *p;
-       int error;
+       int error =3D -EINVAL;
         int len;

         p =3D memchr(buf, '\n', n);
         len =3D p ? p - buf : n;
-
-       for (s =3D &pm_states[state]; state < PM_SUSPEND_MAX; s++, =

state++) {
-               if (*s && !strncmp(buf, *s, len))
+       list_for_each_entry_safe(this, next, head, list) {
+               if (!strncmp(buf, this->name, len)) {
+                       error =3D enter_state(this);
                         break;
+               }
         }
-       if (state < PM_SUSPEND_MAX && *s)
-               error =3D enter_state(state);
-       else
-               error =3D -EINVAL;
         return error ? error : n;
  }

@@ -285,6 +380,7 @@ power_attr(state);

  static struct attribute * g[] =3D {
         &state_attr.attr,
+       &supported_states_attr.attr,
         NULL,
  };

@@ -295,9 +391,20 @@ static struct attribute_group attr_group

  static int __init pm_init(void)
  {
+
         int error =3D subsystem_register(&power_subsys);
         if (!error)
                 error =3D =

sysfs_create_group(&power_subsys.kset.kobj,&attr_group);
+
+       INIT_LIST_HEAD(&pm_states.list);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+       list_add(&disk.list, &pm_states.list);
+#endif
+       list_add(&mem.list, &pm_states.list);
+       list_add(&standby.list, &pm_states.list);
+       current_state =3D &pm_states;
+
         return error;
  }

Index: linux-2.6.17/include/linux/pm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/include/linux/pm.h
+++ linux-2.6.17/include/linux/pm.h
@@ -108,7 +108,29 @@ typedef int __bitwise suspend_state_t;
  #define PM_SUSPEND_STANDBY     ((__force suspend_state_t) 1)
  #define PM_SUSPEND_MEM         ((__force suspend_state_t) 3)
  #define PM_SUSPEND_DISK                ((__force suspend_state_t) 4)
-#define PM_SUSPEND_MAX         ((__force suspend_state_t) 5)
+#define PM_FREQ_CHANGE         ((__force suspend_state_t) 5)
+#define PM_VOLT_CHANGE         ((__force suspend_state_t) 6)
+#define PM_SUSPEND_MAX         ((__force suspend_state_t) 7)
+
+#define PM_NAME_SIZE            16
+#define PM_DESCRIPTION_SIZE     48
+
+struct power_op {
+       struct list_head list;
+       suspend_state_t type;
+       char name[PM_NAME_SIZE];
+       char description[PM_DESCRIPTION_SIZE];
+       unsigned int frequency;         /* in KHz */
+       unsigned int voltage;           /* mV */
+       unsigned int latency;           /* transition latency in us */
+       int     (*prepare_transition)(struct power_op *cur, struct =

power_op *new
);
+       int     (*transition)(struct power_op *cur, struct power_op =

*new);
+       int     (*finish_transition)(struct power_op *cur, struct =

power_op *new)
;
+
+       void *md_data;                  /* arch dependent data =

(dpm_opt) */
+};
+extern struct power_op pm_states;
+extern struct power_op *current_state;

  typedef int __bitwise suspend_disk_method_t;

@@ -128,7 +150,7 @@ struct pm_ops {

  extern void pm_set_ops(struct pm_ops *);
  extern struct pm_ops *pm_ops;
-extern int pm_suspend(suspend_state_t state);
+extern int pm_suspend(struct power_op *state);


  /*
Index: linux-2.6.17/kernel/power/power.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/kernel/power/power.h
+++ linux-2.6.17/kernel/power/power.h
@@ -113,4 +113,4 @@ extern int swsusp_resume(void);
  extern int swsusp_read(void);
  extern int swsusp_write(void);
  extern void swsusp_close(void);
-extern int suspend_enter(suspend_state_t state);
+extern int suspend_enter(struct power_op * state);
Index: linux-2.6.17/Documentation/power/powerop.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.17/Documentation/power/powerop.txt
@@ -0,0 +1,168 @@
+
+The PowerOp Power Management infrastructure.
+
+David Singleton <dsingleton@mvista.com>
+
+25 July 2006
+
+Copyright (c) 2006 MontaVista Software Inc.
+
+0. Introduction
+
+The goal of PowerOp power management is to provide a framework that =

unifies
+and simplifies the various power management infrastructures in Linux.  =

The
+three infrastructures Power Op is concerned with are:
+
+       1) basic suspend/resume power management (CONFIG_PM)
+
+       2) basic processor frequency management (CONFIG_CPUFREQ)
+
+       3) SourceForge's Dynamic Power Management (CONFIG_DPM)
+
+All three power management infrastructures are concerned with =

controlling
+power states of the system, and interestingly enough they all perform =

the
+same basic operational steps to control changes in power state.
+
+PowerOp uses the existing power management sysfs infrastructure and =

extends it
+to perform cpufreq and dynamic power management operations. The =

traditional
+suspend to memory or disk (or swap) infrastructure has the correct =

operational
+structure that supports all types of power state change.
+
+The CPUFREQ table based frequency control makes controlling cpu =

frequency
+simple and straight forward.  The user doesn't get to set the cpu to
+any speed, but only to supported speeds that have been provided by
+the hardware vendor and validated.
+
+Dynamic Power Management treats all types of power states as operating =

points,
+wether it's a suspend operating point, a particular frequency, or a =

specific
+voltage.
+
+By combining the best of all of these power management infrastructures
+PowerOp uses the operational structure of tradition CONFIG_PM power
+management and converts all power states, frequency, voltage, idle or
+suspend to the CPUFREQ concept of only supported and validated =

operating
+points.
+
+PowerOp then becomes a simplified power management infrastructure in =

that
+only operating points that are supported and validated are available
+to the user.  Control of all operating points are done by the operating
+point name.  The user cannot supply invalid, or malicious,
+parameters that would hang or crash the system.
+
+1) PowerOp interface.
+
+To simplify power management all operations take place through two =

sysfs
+files, /sys/power/state and /sys/power/supported_states.  The 'state' =

file
+shows the current operating point of the system.  The readonly
+'supported_states' file shows the operating points the system supports.
+
+Supported operating points are displayed in tuple format of:
+
+<name, frequency, voltage, transition latency, description>
+
+The supported_states file contains rows of tuples with each
+tuple describing a supported operating point of the system.
+The supported_states file looks like a merge between the old
+/sys/power/state file and a cpufreq table.
+
+The system can transition to any of the supported states by simply
+storing the operating point name in the /sys/power/state file.
+
+To allow user space notification of events, like low battery, lid of
+the notebook being closed, etc.  PowerOp notifies the user through
+the hotplug interface.
+
+
+2) PowerOP Operating Points.
+
+An operating point is represented by the power_op struct which =

contains:
+
+struct power_op {
+        struct list_head list;
+        suspend_state_t type;
+        char name[PM_NAME_SIZE];
+        char description[PM_DESCRIPTION_SIZE];
+        unsigned int frequency;         /* in KHz */
+        unsigned int voltage;           /* mV */
+        unsigned int latency;           /* transition latency in us */
+        int     (*prepare_transition)(struct power_op *cur, struct =

power_op *ne
w);
+        int     (*transition)(struct power_op *cur, struct power_op =

*new);
+        int     (*finish_transition)(struct power_op *cur, struct =

power_op *new
);
+
+        void *md_data;                  /* arch dependent data  */
+};
+
+Each operating point has its own functions for preparing to transition,
+transitioning and finishing transition.  Cpu frequency operating points
+will probably share their op vectors, idle and suspend operating =

points my have
+different op vectors.
+
+
+3) Traditional Operation of Power Management Code.
+
+All three power management infrastructures have the same operational =

model.
+All three follow the PM model of preparing to suspend,  suspending,
+and finish the state change.  It was easiest to follow the model
+enforced by the traditional power management and use the three step =

process of:
+
+       1) get ready to change state
+       2) change state
+       3) finish changes
+
+Cpufreq infrastructure makes three calls to change the frequency of the
+processor:
+
+       1) cpufreq_notify_transition(&freq, CPUFREQ_PRECHANGE);
+
+       2) acpi_processor_set_performance (data, j, next_state);
+
+       3) cpufreq_notify_transition(&freq, CPUFREQ_POSTCHANGE);
+
+DPM uses these three calls to change frequency and/or voltage:
+
+       1) dpm_driver_scale(SCALE_PRECHANGE, new);
+
+       2) clk_set_rate(prcm_set, new->md_opt.prcm_clock);
+
+       3) dpm_driver_scale(SCALE_POStCHANGE, new);
+
+PM uses these three calls to suspend:
+
+       1) suspend_prepare(state);
+
+       2) suspend_enter(state->type);
+
+       3) suspend_finish(state);
+
+
+4) PowerOP Operation.
+
+PowerOP uses the following three calls to transition to a new operating
+point.
+
+       prepare_to_transition(cur_state, new_state);
+
+       transition(cur_state, new_state);
+
+       finish_transistion(cur_state, new_state);
+
+The parameters are pointers to operating point structures, struct =

power_op.
+
+Power OP is a simplified version of all three of these infrastructures =

in
+that it only deals with operating points, and more specifically with
+supported operating points.  Power Op presents a set of supported =

operating
+points to the user.  This is similar to the cpufreq table concept in =

that
+only supported and validated frequencies are avaliable.
+
+The definition of the operating point is done in a manner similar to =

cpufreqs
+in that the supported operating frequency, voltage and transition =

latency,
+are predefined (by the hardware vendor) and validated.
+
+The user maninuplates the operting points of the system by the
+name of the operating points.  This simplifies both the code and the
+control of the system's operating points in the PowerOp daemon.
+
+All supported operating points are defined at compile time and
+the user sets the system to different operating points by
+the operating point name.
+
