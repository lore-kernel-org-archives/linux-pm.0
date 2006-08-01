From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Core PowerOP Interface Update [Was: Re: [RFC] PowerOP
 Take 3, ARM OMAP1 platform support 3/5]
Date: Wed, 02 Aug 2006 00:52:00 +0400
Message-ID: <44CFBEF0.2000700@gmail.com>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
	<200607261728.40443.david-b@pacbell.net>
	<44CD0937.6060905@gmail.com>
	<200607301858.52096.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060707080700020704010500"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607301858.52096.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Locke <matt@nomadgs.com>, patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------060707080700020704010500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Brownell wrote:
> On Sunday 30 July 2006 12:32 pm, Eugeny S. Mints wrote:
>
>   
>>> Whereas I say that arch dependent is arch dependent ... unless
>>> that "core" is indirecting through "struct powerop_point *", the
>>> interface doesn't include the struct at all.  Ergo my comment.
>>>
>>>   
>>>       
>> Let me try to set it this way.
>> struct powerop_point is an arch independent piece in the sense that any 
>> platform
>> which leverages PorewOP concept should implement struct powerop_point.
>> struct powerop_point is fundamental component that has to be defined by
>> a platfrom.
>>     
>
> We're not communicating here ... if the contents are arch-specific,
> it doesn't matter to the interface except that it exist.  A better
> way to define it would be:
>
> 	struct powerop_point {
> 		struct kobject	kobj;
> 		void		*arch_hook;
> 		// presumably there will be method hooks too, like
> 		int		(*enter_prepare)(struct powerop_point *);
> 		int		(*enter)(struct powerop_point *);
> 		int		(*enter_complete)(struct powerop_point *);
> 	};
>
> where that "void *" is the entire arch hook, and the kobj holds the
> name and represents the /sys/power/... directory for that arch.
>
> (Those methods are just placeholders for what might be needed; the
> prepare might suspend certain devices, the complete might resume
> them with different underlying clock or voltage availability, and
> the enter would change voltage, clocks, and whatever else.)
>
>
>   
Please find proposal of updated interface attached. The update
addresses "void *" approach but does not take hooks outlined
above. Updated approach allows to handle lists of named
operating points inside as well as outside the PowerOP Core
layer.

The main terms and assumptions are:
- set of a platform power parameters: platform parameters which
  affect platform power consumption

- operating point: _fixed_length_ array of power parameters.
  length varies from platform to  platform. For more details
  and discussion of fixed length approach see
  http://lists.osdl.org/pipermail/linux-pm/2006-August/003156.html

(the following explains why there are no hooks outlined
by David in my updated interface proposal)
- assuming we deferred discussion of whether sleep operating
  points should be handled in the same way with others (seems
  we agree here) and consider all except sleep ops.

-I guess you're talking about drivers notifications in your
 explanation about arch dependent hooks to allow a certain  driver to
 adjust something (stop and restart DMA for ex) it needs in regard to
 changing to new operating point.

 Although the question which layer in PM framework should
 be responsible for driver notification in the pre/post change
 manner is for further discussion I consider that it's up to
 device driver to define what are steps to handle a transition.
 There is just no sense to extract that [essentially a driver's]
 functionality to any other layer. Thus, there indeed should
 be three phase for any transition from an operating point
 to an operating point but all we need is to notify interested
 party of the system about upcoming/completed change and
 this has nothing to do with something per operating point
 specific.

 The summary is that I don't see any reason to have that
 hooks to be defined per operating point.

 IMO clock/voltage framework layer should be responsible
 for issuing pre/post drivers notifications since a certain
 driver is tied with a particular clock(s)/voltage(s) and we
 know about the mapping at the point when a certain driver
 requests those resources. Such approach could allow to
 minimize overhead even comparing to the current separated
 pre/post lists of notifiers approach [in cpufreq for ex]
 because different drivers will monitor different and only
 chosen clock(s)/voltage(s) changes. Again I feel this like
 a topic for a separate discussion. 

Thanks,
Eugeny
>> In this way struct powerop_point _is_ part of PowerOP interface .
>> Let me refer to the picture of proposed framework as well. PowerOP is
>> interface between PM Core and any upper layer in the framework. Pushing
>> power parameters definition down to PM Core interface (into some patch with
>> a name related to pm core rather than to PowerOP) makes understanding
>> of the framework layers much harder IMO.
>>     
>
> If the arch wants to expose parameters for a given operating point,
> that'd be its own responsibility ... and trivial, there's lots of
> utility code to do that.
>
>
>   
>> If you are  referring to the certain implementation let assume that I put
>> "struct powerop_point;" instead of inclusion of 'asm/powrop.h' in
>> include/linux/powerop.h file.
>>     
>
> I'd rather assume something as shown above ... something where it's
> reasonable for the core to access the struct, if its declaration
> must for whatever reason be visible to the core.  :)
>
>
>   
>> This way you get a compilable arch independent powerop core
>> piece but let me ask what for? To allow arch independent powerop core
>> to be standalone compilable?
>>     
>
> Call it "information hiding" or "clean interface design".  There's
> no reason for the core to know _anything_ about the arch-specific
> details.  You've set it up so they will, which means that the code
> will probably evolve to try using that information.  This should be
> a loosely coupled interface, not a tightly coupled one.
>
> One artifact of an effective loosely coupled interface design is
> that it's easy to completely revamp the implementation of one of
> the coupled components without changing the other.  In this case,
> one component is (minimal) core code, the other is platform specific
> code implementing each operating point.
>
>
>   
>> It's just useless: if the arch you are  
>> building for
>> does not implement definition of struct powerop_point you just  defer
>> compilation error to the link phase. Currently you can chose PowerOP
>> core only if you chose an arch which implements arch dependent piece
>> of PowerOP.
>>     
>
> It's very useful.  How could you have modules defining new operating
> points, with new parameters, with tight coupling?  Surely it should
> be possible to link every operating point except the initial "system
> startup" point dynamically, using kernel modules?
>
> (That bootstrap issue needs looking at too.  I think there may well
> need to be an arch independent initial operating point.  That's a
> topic for a different thread though.)
>
>  
>
>   
>>>>>  - In general, shouldn't an operating point be board-specific, so
>>>>>    that the parts of the system outside the SOC can be included
>>>>>   
>>>>>       
>>>>>           
>>>> good question. Basically current assumption is that definition is for an SoC
>>>> and the values are board specific. While definition will most likely be the
>>>> same for every board based on a certain SoC I can imaging for example
>>>> that we can have an external clock source for an external hw on a board.
>>>>     
>>>>         
>>> I agree that parts of an OP will merit that approach.  But ... the SOC
>>> is not the only system component that needs managing, and it won't always
>>> be practical to shuffle the others under the "device-specfic PM" tent.
>>>
>>>       
>>  
>> OK, I am almost ready to buy this per SoC and per baord-specific OP 
>> definition approach.
>>     
>
> Code can come later.  :)
>
>
>   
>> But let me ask first whether you have at least one example of  
>> a platform which fits into this model nowadays?
>>     
>
> Certainly.  Any two boards using the same SOC but different
> external circuitry would naturally fit that model ... be they
> OMAP boards, or PXA ones, or Atmel ones, etc.
>
>
>   
>>>> Since that  powerop_point structure definition could be board specific
>>>> but that's where I'd prefer to get some input from the community to
>>>> decide whether we have to move to board specific operating point
>>>> structure definition.
>>>>     
>>>>         
>>> My input:  make it easy to partition things into components.  One way
>>> to do that might be to have an SOC component, multiple device components,
>>> and a board-specific glue component that connects them in the right way.
>>>
>>>   
>>>       
>> please elaborate multiple device components.
>>     
>
> Considering only OMAP boards ... there are a variety of different
> power management chips, audio chips, touchscreen controllers, and
> backlight arrangements.  It's reasonable to expect that two points
> differ in which of those may be active.
>
> - Dave
>
>
>
>   


--------------060707080700020704010500
Content-Type: text/x-patch;
 name="powerop.h.interface.revised.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerop.h.interface.revised.patch"

diff --git a/include/linux/powerop.h b/include/linux/powerop.h
new file mode 100644
index 0000000..eebff76
--- /dev/null
+++ b/include/linux/powerop.h
@@ -0,0 +1,40 @@
+/*
+ * PowerOP core definitions
+ *
+ * Author: Todd Poynor <tpoynor@mvista.com>
+ * Interface update by Eugeny S. Mints <eugeny.mints@gmail.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __POWEROP_H__
+#define __POWEROP_H__
+
+struct powerop_named_op {
+	struct kobject  kobj;   /* hook to reference an op by a name */
+	void           *md_opt; /* arch dependent set of power parameters */
+};
+
+struct powerop_driver {
+	char *name;
+	int (*set_point)(void *md_opt);
+	int (*get_point)(void *md_opt);
+};
+
+/* Interface to upper PMF layers */
+int powerop_set_point(powerop_named_op *opt);
+int powerop_get_point(powerop_named_op *opt);
+
+/* Interface to an arch PM core */
+int powerop_driver_register(struct powerop_driver *p);
+void powerop_driver_unregister(struct powerop_driver *p);
+
+/* Interface to handle named OP by PowerOP core layer */
+int powerop_register_point(const char *id, void *md_opt);
+int powerop_unregister_point(const char *id);
+int powerop_select_point(const char *id);
+
+#endif /* __POWEROP_H__ */
+


--------------060707080700020704010500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------060707080700020704010500--
