From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Core PowerOP Interface Update [Was: Re: [RFC]
	PowerOP Take 3, ARM OMAP1 platform support 3/5]
Date: Thu, 3 Aug 2006 06:07:14 +0400
Message-ID: <c55240ed0608021907q7c3426fcj88bab45f66a6d729@mail.gmail.com>
References: <c55240ed0607201301y7ac3be76o6f173d1b6ab50c1d@mail.gmail.com>
	<200607261728.40443.david-b@pacbell.net> <44CD0937.6060905@gmail.com>
	<200607301858.52096.david-b@pacbell.net> <44CFBEF0.2000700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_8229_213442.1154570834683"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44CFBEF0.2000700@gmail.com>
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
Cc: patrick.mochel@intel.com, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

------=_Part_8229_213442.1154570834683
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please ignore the patch attached to the previous email and
consider current patch attached.

This patch contains complete PowerOP Core layer rework.
Other patches follow shortly.

My comments below remain valid.

Thanks,
Eugeny

2006/8/2, Eugeny S. Mints <eugeny.mints@gmail.com>:
> David Brownell wrote:
> > On Sunday 30 July 2006 12:32 pm, Eugeny S. Mints wrote:
> >
> >
> >>> Whereas I say that arch dependent is arch dependent ... unless
> >>> that "core" is indirecting through "struct powerop_point *", the
> >>> interface doesn't include the struct at all.  Ergo my comment.
> >>>
> >>>
> >>>
> >> Let me try to set it this way.
> >> struct powerop_point is an arch independent piece in the sense that any
> >> platform
> >> which leverages PorewOP concept should implement struct powerop_point.
> >> struct powerop_point is fundamental component that has to be defined by
> >> a platfrom.
> >>
> >
> > We're not communicating here ... if the contents are arch-specific,
> > it doesn't matter to the interface except that it exist.  A better
> > way to define it would be:
> >
> >       struct powerop_point {
> >               struct kobject  kobj;
> >               void            *arch_hook;
> >               // presumably there will be method hooks too, like
> >               int             (*enter_prepare)(struct powerop_point *);
> >               int             (*enter)(struct powerop_point *);
> >               int             (*enter_complete)(struct powerop_point *);
> >       };
> >
> > where that "void *" is the entire arch hook, and the kobj holds the
> > name and represents the /sys/power/... directory for that arch.
> >
> > (Those methods are just placeholders for what might be needed; the
> > prepare might suspend certain devices, the complete might resume
> > them with different underlying clock or voltage availability, and
> > the enter would change voltage, clocks, and whatever else.)
> >
> >
> >
> Please find proposal of updated interface attached. The update
> addresses "void *" approach but does not take hooks outlined
> above. Updated approach allows to handle lists of named
> operating points inside as well as outside the PowerOP Core
> layer.
>
> The main terms and assumptions are:
> - set of a platform power parameters: platform parameters which
>  affect platform power consumption
>
> - operating point: _fixed_length_ array of power parameters.
>  length varies from platform to  platform. For more details
>  and discussion of fixed length approach see
>  http://lists.osdl.org/pipermail/linux-pm/2006-August/003156.html
>
> (the following explains why there are no hooks outlined
> by David in my updated interface proposal)
> - assuming we deferred discussion of whether sleep operating
>  points should be handled in the same way with others (seems
>  we agree here) and consider all except sleep ops.
>
> -I guess you're talking about drivers notifications in your
>  explanation about arch dependent hooks to allow a certain  driver to
>  adjust something (stop and restart DMA for ex) it needs in regard to
>  changing to new operating point.
>
>  Although the question which layer in PM framework should
>  be responsible for driver notification in the pre/post change
>  manner is for further discussion I consider that it's up to
>  device driver to define what are steps to handle a transition.
>  There is just no sense to extract that [essentially a driver's]
>  functionality to any other layer. Thus, there indeed should
>  be three phase for any transition from an operating point
>  to an operating point but all we need is to notify interested
>  party of the system about upcoming/completed change and
>  this has nothing to do with something per operating point
>  specific.
>
>  The summary is that I don't see any reason to have that
>  hooks to be defined per operating point.
>
>  IMO clock/voltage framework layer should be responsible
>  for issuing pre/post drivers notifications since a certain
>  driver is tied with a particular clock(s)/voltage(s) and we
>  know about the mapping at the point when a certain driver
>  requests those resources. Such approach could allow to
>  minimize overhead even comparing to the current separated
>  pre/post lists of notifiers approach [in cpufreq for ex]
>  because different drivers will monitor different and only
>  chosen clock(s)/voltage(s) changes. Again I feel this like
>  a topic for a separate discussion.
>
> Thanks,
> Eugeny
> >> In this way struct powerop_point _is_ part of PowerOP interface .
> >> Let me refer to the picture of proposed framework as well. PowerOP is
> >> interface between PM Core and any upper layer in the framework. Pushing
> >> power parameters definition down to PM Core interface (into some patch with
> >> a name related to pm core rather than to PowerOP) makes understanding
> >> of the framework layers much harder IMO.
> >>
> >
> > If the arch wants to expose parameters for a given operating point,
> > that'd be its own responsibility ... and trivial, there's lots of
> > utility code to do that.
> >
> >
> >
> >> If you are  referring to the certain implementation let assume that I put
> >> "struct powerop_point;" instead of inclusion of 'asm/powrop.h' in
> >> include/linux/powerop.h file.
> >>
> >
> > I'd rather assume something as shown above ... something where it's
> > reasonable for the core to access the struct, if its declaration
> > must for whatever reason be visible to the core.  :)
> >
> >
> >
> >> This way you get a compilable arch independent powerop core
> >> piece but let me ask what for? To allow arch independent powerop core
> >> to be standalone compilable?
> >>
> >
> > Call it "information hiding" or "clean interface design".  There's
> > no reason for the core to know _anything_ about the arch-specific
> > details.  You've set it up so they will, which means that the code
> > will probably evolve to try using that information.  This should be
> > a loosely coupled interface, not a tightly coupled one.
> >
> > One artifact of an effective loosely coupled interface design is
> > that it's easy to completely revamp the implementation of one of
> > the coupled components without changing the other.  In this case,
> > one component is (minimal) core code, the other is platform specific
> > code implementing each operating point.
> >
> >
> >
> >> It's just useless: if the arch you are
> >> building for
> >> does not implement definition of struct powerop_point you just  defer
> >> compilation error to the link phase. Currently you can chose PowerOP
> >> core only if you chose an arch which implements arch dependent piece
> >> of PowerOP.
> >>
> >
> > It's very useful.  How could you have modules defining new operating
> > points, with new parameters, with tight coupling?  Surely it should
> > be possible to link every operating point except the initial "system
> > startup" point dynamically, using kernel modules?
> >
> > (That bootstrap issue needs looking at too.  I think there may well
> > need to be an arch independent initial operating point.  That's a
> > topic for a different thread though.)
> >
> >
> >
> >
> >>>>>  - In general, shouldn't an operating point be board-specific, so
> >>>>>    that the parts of the system outside the SOC can be included
> >>>>>
> >>>>>
> >>>>>
> >>>> good question. Basically current assumption is that definition is for an SoC
> >>>> and the values are board specific. While definition will most likely be the
> >>>> same for every board based on a certain SoC I can imaging for example
> >>>> that we can have an external clock source for an external hw on a board.
> >>>>
> >>>>
> >>> I agree that parts of an OP will merit that approach.  But ... the SOC
> >>> is not the only system component that needs managing, and it won't always
> >>> be practical to shuffle the others under the "device-specfic PM" tent.
> >>>
> >>>
> >>
> >> OK, I am almost ready to buy this per SoC and per baord-specific OP
> >> definition approach.
> >>
> >
> > Code can come later.  :)
> >
> >
> >
> >> But let me ask first whether you have at least one example of
> >> a platform which fits into this model nowadays?
> >>
> >
> > Certainly.  Any two boards using the same SOC but different
> > external circuitry would naturally fit that model ... be they
> > OMAP boards, or PXA ones, or Atmel ones, etc.
> >
> >
> >
> >>>> Since that  powerop_point structure definition could be board specific
> >>>> but that's where I'd prefer to get some input from the community to
> >>>> decide whether we have to move to board specific operating point
> >>>> structure definition.
> >>>>
> >>>>
> >>> My input:  make it easy to partition things into components.  One way
> >>> to do that might be to have an SOC component, multiple device components,
> >>> and a board-specific glue component that connects them in the right way.
> >>>
> >>>
> >>>
> >> please elaborate multiple device components.
> >>
> >
> > Considering only OMAP boards ... there are a variety of different
> > power management chips, audio chips, touchscreen controllers, and
> > backlight arrangements.  It's reasonable to expect that two points
> > differ in which of those may be active.
> >
> > - Dave
> >
> >
> >
> >
>
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
>
>
>

------=_Part_8229_213442.1154570834683
Content-Type: text/plain; name=powerop.core.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eqehmjmp
Content-Disposition: attachment; filename="powerop.core.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvTWFrZWZpbGUgYi9kcml2ZXJzL01ha2VmaWxlCmluZGV4IGZj
MmQ3NDQuLmY4ZWFmMzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvTWFrZWZpbGUKKysrIGIvZHJpdmVy
cy9NYWtlZmlsZQpAQCAtNjUsNiArNjUsNyBAQCBvYmotJChDT05GSUdfSVNETikJCSs9IGlzZG4v
CiBvYmotJChDT05GSUdfRURBQykJCSs9IGVkYWMvCiBvYmotJChDT05GSUdfTUNBKQkJKz0gbWNh
Lwogb2JqLSQoQ09ORklHX0VJU0EpCQkrPSBlaXNhLworb2JqLSQoQ09ORklHX1BPV0VST1ApCQkr
PSBwb3dlcm9wLwogb2JqLSQoQ09ORklHX0NQVV9GUkVRKQkJKz0gY3B1ZnJlcS8KIG9iai0kKENP
TkZJR19NTUMpCQkrPSBtbWMvCiBvYmotJChDT05GSUdfTkVXX0xFRFMpCQkrPSBsZWRzLwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wb3dlcm9wL0tjb25maWcgYi9kcml2ZXJzL3Bvd2Vyb3AvS2NvbmZp
ZwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi45NGQyNDU5Ci0tLSAvZGV2L251
bGwKKysrIGIvZHJpdmVycy9wb3dlcm9wL0tjb25maWcKQEAgLTAsMCArMSwxMiBAQAorIworIyBw
b3dlcm9wCisjCisKK21lbnUgIlBvd2VyT1AgKFBvd2VyIE1hbmFnZW1lbnQpIgorCitjb25maWcg
UE9XRVJPUAorCWJvb2wgIlBvd2VyT1AgQ29yZSIKKwloZWxwCisKK2VuZG1lbnUKKwpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wb3dlcm9wL01ha2VmaWxlIGIvZHJpdmVycy9wb3dlcm9wL01ha2VmaWxl
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjEzMWI5ODMKLS0tIC9kZXYvbnVs
bAorKysgYi9kcml2ZXJzL3Bvd2Vyb3AvTWFrZWZpbGUKQEAgLTAsMCArMSwyIEBACitvYmotJChD
T05GSUdfUE9XRVJPUCkJCSs9IHBvd2Vyb3AubworCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2Vy
b3AvcG93ZXJvcC5jIGIvZHJpdmVycy9wb3dlcm9wL3Bvd2Vyb3AuYwpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwLi5lNzVhMTRkCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9w
b3dlcm9wL3Bvd2Vyb3AuYwpAQCAtMCwwICsxLDMxNSBAQAorLyoKKyAqIFBvd2VyT1AgQ29yZSBy
b3V0aW5lcworICoKKyAqIEF1dGhvcjogVG9kZCBQb3lub3IgPHRwb3lub3JAbXZpc3RhLmNvbT4K
KyAqIEludGVyZmFjZSB1cGRhdGUgYnkgRXVnZW55IFMuIE1pbnRzIDxldWdlbnkubWludHNAZ21h
aWwuY29tPgorICoKKyAqIDIwMDUgKGMpIE1vbnRhVmlzdGEgU29mdHdhcmUsIEluYy4gVGhpcyBm
aWxlIGlzIGxpY2Vuc2VkIHVuZGVyCisgKiB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIHZlcnNpb24gMi4gVGhpcyBwcm9ncmFtCisgKiBpcyBsaWNlbnNlZCAiYXMg
aXMiIHdpdGhvdXQgYW55IHdhcnJhbnR5IG9mIGFueSBraW5kLCB3aGV0aGVyIGV4cHJlc3MKKyAq
IG9yIGltcGxpZWQuCisgKi8KKyNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KKyNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CisjaW5jbHVkZSA8bGludXgv
ZXJybm8uaD4KKyNpbmNsdWRlIDxsaW51eC9wb3dlcm9wLmg+CisKK3N0YXRpYyBzdHJ1Y3QgcG93
ZXJvcF9kcml2ZXIgKnBvd2Vyb3BfZHJpdmVyOworCisvKiBsaXN0IG9mIG5hbWVkIG9wZXJhdGlu
ZyBwb2ludHMgbWFpbnRhaW5lZCBieSBQb3dlck9QIENvcmUgbGF5ZXIgKi8KK3N0YXRpYyBzdHJ1
Y3QgbGlzdF9oZWFkIG5hbWVkX29wdF9saXN0Oworc3RhdGljIERFQ0xBUkVfTVVURVgobmFtZWRf
b3B0X2xpc3RfbXV0ZXgpOworc3RhdGljIGludCBwb3dlcm9wX2luaXQ7CisKK3N0cnVjdCBuYW1l
ZG9wIHsKKwlzdHJ1Y3QgcG93ZXJvcF9wb2ludCBwb2ludDsKKwlzdHJ1Y3QgbGlzdF9oZWFkIG5v
ZGU7Cit9OworCisvKiBodyBhY2Nlc3Mgc2VyaWFsaXphdGlvbiAqLworc3RhdGljIERFQ0xBUkVf
TVVURVgocG93ZXJvcF9tdXRleCk7CisKKy8qIEZvcndhcmQgZGVjbGFyYXRpb24gKi8KK2ludCBw
b3dlcm9wX3NldF9wb2ludChzdHJ1Y3QgcG93ZXJvcF9wb2ludCAqcG9pbnQpOworCitpbnQgCitw
b3dlcm9wX2RyaXZlcl9yZWdpc3RlcihzdHJ1Y3QgcG93ZXJvcF9kcml2ZXIgKnApCit7CisJaW50
IGVycm9yID0gMDsKKworCWlmICghIHBvd2Vyb3BfZHJpdmVyKSB7CisJCXByaW50ayhLRVJOX0lO
Rk8gIlBvd2VyT1AgcmVnaXN0ZXJpbmcgZHJpdmVyICVzLlxuIiwgcC0+bmFtZSk7CisJCXBvd2Vy
b3BfZHJpdmVyID0gcDsKKworCX0gZWxzZQorCQllcnJvciA9IC1FQlVTWTsKKworCXJldHVybiBl
cnJvcjsKK30KKwordm9pZCAKK3Bvd2Vyb3BfZHJpdmVyX3VucmVnaXN0ZXIoc3RydWN0IHBvd2Vy
b3BfZHJpdmVyICpwKQoreworCWlmIChwb3dlcm9wX2RyaXZlciA9PSBwKSB7CisJCXByaW50ayhL
RVJOX0lORk8gIlBvd2VyT1AgdW5yZWdpc3RlcmluZyBkcml2ZXIgJXMuXG4iLCBwLT5uYW1lKTsK
KwkJcG93ZXJvcF9kcml2ZXIgPSBOVUxMOworCX0KK30KKworRVhQT1JUX1NZTUJPTF9HUEwocG93
ZXJvcF9kcml2ZXJfcmVnaXN0ZXIpOworRVhQT1JUX1NZTUJPTF9HUEwocG93ZXJvcF9kcml2ZXJf
dW5yZWdpc3Rlcik7CisKKy8qIAorICogcG93ZXJvcF9yZWdpc3Rlcl9uYW1lZF9wb2ludCAtIGFk
ZCBuZXcgb3BlcmF0aW5nIHBvaW50IHdpdGggYSBnaXZlbiBuYW1lIHRvCisgKiBvcGVyYXRpbmcg
cG9pbnRzIGxpc3QKKyAqCisgKiBJTlBVVAorICogICBpZCAgICAgLSBvcGVyYXRpbmcgcG9pbnQg
bmFtZQorICogICBtZF9vcHQgLSBzZXQgb2YgcG93ZXIgcGFyYW1ldGVycyB2YWx1ZQorICoKKyAq
IE9VVFBVVAorICogICBub25lCisgKgorICogUkVUVVJOCisgKiAgIHplcm8gb24gc3VjY2Vzcywg
ZXJyb3IgY29kZSBvdGhlcndpc2UKKyAqICAgIAorICovCitpbnQgCitwb3dlcm9wX3JlZ2lzdGVy
X25hbWVkX3BvaW50KGNvbnN0IGNoYXIgKmlkLCB2b2lkICptZF9vcHQpCit7CisJc3RydWN0IG5h
bWVkb3AgKm9wdDsKKwlpbnQgZXJyb3I7CisKKwlpZiAoKCFwb3dlcm9wX2luaXQpIHx8IChpZCA9
PSBOVUxMKSB8fCAobWRfb3B0ID09IE5VTEwpKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWlmICgo
b3B0ID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IG5hbWVkb3ApLCBHRlBfS0VSTkVMKSkgPT0gTlVM
TCkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwltZW1zZXQob3AsIDAsIHNpemVvZihzdHJ1Y3QgbmFt
ZWRvcCkpOworCWtvYmplY3Rfc2V0X25hbWUoJm9wdC0+cG9pbnQua29iaiwgaWQpOworCW9wdC0+
cG9pbnQubWRfb3B0ID0gbWRfb3B0OworCisJZG93bigmbmFtZWRfb3B0X2xpc3RfbXV0ZXgpOwor
CWxpc3RfYWRkX3RhaWwoJm9wdC0+bm9kZSwgJm5hbWVkX29wdF9saXN0KTsKKwl1cCgmbmFtZWRf
b3B0X2xpc3RfbXV0ZXgpOworCisJcmV0dXJuIDA7Cit9CisKKy8qIAorICogcG93ZXJvcF91bnJl
Z2lzdGVyX25hbWVkX3BvaW50IC0gc2VhcmNoIGZvciBvcGVyYXRpbmcgcG9pbnQgd2l0aCBzcGVj
aWZpZWQKKyAqIG5hbWUgYW5kIHJlbW92ZSBpdCBmcm9tIG9wZXJhdGluZyBwb2ludHMgbGlzdAor
ICoKKyAqIElOUFVUCisgKiAgIGlkIC0gbmFtZSBvZiBvcGVyYXRpbmcgcG9pbnQKKyAqCisgKiBP
VVRQVVQKKyAqICAgbm9uZQorICoKKyAqIFJFVFVSTgorICogICB6ZXJvIG9uIHN1Y2Nlc3MsIC1F
SU5WQUwgaWYgbm8gb3BlcmF0aW5nIHBvaW50IGlzIGZvdW5kCisgKiAgICAKKyAqLworaW50IAor
cG93ZXJvcF91bnJlZ2lzdGVyX25hbWVkX3BvaW50KGNvbnN0IGNoYXIgKmlkKQoreworCXN0cnVj
dCBuYW1lZG9wICpvcHQsICp0bXBvcHQ7CisJaW50IHJldCA9IC1FSU5WQUw7CisKKwlpZiAoKCFw
b3dlcm9wX2luaXQpIHx8IChpZCA9PSBOVUxMKSkKKwkJcmV0dXJuIHJldDsKKworCWRvd24oJm5h
bWVkX29wdF9saXN0X211dGV4KTsKKworCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShvcHQsIHRt
cG9wdCwgJm5hbWVkX29wdF9saXN0LCBub2RlKSB7CisJCWlmIChzdHJjbXAob3AtPmtvYmoubmFt
ZSwgaWQpID09IDApIHsKKwkJCWxpc3RfZGVsKCZvcHQtPm5vZGUpOworCQkJa2ZyZWUob3B0KTsK
KwkJCXJldCA9IDA7CisJCQlicmVhazsKKwkJfQorCX0KKworCXVwKCZuYW1lZF9vcHRfbGlzdF9t
dXRleCk7CisKKwlyZXR1cm4gcmV0OworfQorCisvKiAKKyAqIHBvd2Vyb3Bfc2V0X25hbWVkX3Bv
aW50IC0gc2VhcmNoIGZvciBvcGVyYXRpbmcgcG9pbnQgd2l0aCBzcGVjaWZpZWQgbmFtZSAKKyAq
IGFuZCBzd2l0Y2ggdGhlIHN5c3RlbSB0byB0aGUgc3BlY2lmaWVkIG9wZXJhdGluZyBwb2ludAor
ICoKKyAqIElOUFVUCisgKiAgIGlkIC0gbmFtZSBvZiBvcGVyYXRpbmcgcG9pbnQKKyAqCisgKiBP
VVRQVVQKKyAqICAgbm9uZQorICoKKyAqIFJFVFVSTgorICogICAgIHplcm8gICBvbiBzdWNjZXNz
IAorICogICAtRUlOVkFMICBpZiBubyBvcGVyYXRpbmcgcG9pbnQgaXMgZm91bmQgb3IgZXJyb3Ig
Y29kZSBvdGhlcndpc2UKKyAqLworaW50IAorcG93ZXJvcF9zZXRfbmFtZWRfcG9pbnQoY29uc3Qg
Y2hhciAqaWQpCit7CisJc3RydWN0IG5hbWVkb3AgKm9wdCwgKnNlbGVjdGVkX29wdCA9IE5VTEw7
CisJaW50IHJldDsKKworCWlmICgoIXBvd2Vyb3BfaW5pdCkgfHwgKGlkID09IE5VTEwpKQorCQly
ZXR1cm4gcmV0OworCisJZG93bigmbmFtZWRfb3B0X2xpc3RfbXV0ZXgpOworCisJbGlzdF9mb3Jf
ZWFjaF9lbnRyeShvcHQsICZuYW1lZF9vcHRfbGlzdCwgbm9kZSkgeworCQlpZiAoc3RyY21wKG9w
dC0+a29iai5uYW1lLCBpZCkgPT0gMCkgeworCQkJc2VsZWN0ZWRfb3B0ID0gb3B0OworCQkJYnJl
YWs7CisJCX0KKwl9CisKKwlyZXQgPSAoc2VsZWN0ZWRfb3B0ID09IE5VTEwpID8KKwkJLUVJTlZB
TCA6IHBvd2Vyb3Bfc2V0X3BvaW50KG9wdC0+cG9pbnQpOworCisJdXAoJm5hbWVkX29wdF9saXN0
X211dGV4KTsKKworCXJldHVybiByZXQ7Cit9CisKKy8qIAorICogcG93ZXJvcF9nZXRfbmFtZWRf
cG9pbnQgLSBzZWFyY2ggZm9yIG9wZXJhdGluZyBwb2ludCB3aXRoIHNwZWNpZmllZCBuYW1lIAor
ICogYW5kIHJldHVybiB2YWx1ZSBvZiBwb3dlciBwYXJhbWV0ZXJzIGNvcnJlc3BvbmRpbmcgdG8g
dGhlIG9wZXJhdGluZyBwb2ludAorICoKKyAqIElOUFVUCisgKiAgIGlkIC0gbmFtZSBvZiBvcGVy
YXRpbmcgcG9pbnQKKyAqCisgKiBPVVRQVVQKKyAqICAgbWRfb3B0IC0gcG93ZXIgcGFyYW1ldGVy
IHZhbHVlcworICoKKyAqIFJFVFVSTgorICogICB6ZXJvIG9uIHN1Y2Nlc3MsIC1FSU5WQUwgaWYg
bm8gb3BlcmF0aW5nIHBvaW50IGlzIGZvdW5kCisgKi8KK2ludCAKK3Bvd2Vyb3BfZ2V0X25hbWVk
X3BvaW50KGNvbnN0IGNoYXIgKmlkLCB2b2lkICptZF9vcHQpCit7CisJaW50IHJldCA9IC1FSU5W
QUw7CisJc3RydWN0IG5hbWVkb3AgKm9wdDsKKworCWlmICgoIXBvd2Vyb3BfaW5pdCkgfHwgKGlk
ID09IE5VTEwpIHx8IChtZF9vcHQgPT0gTlVMTCkpCisJCXJldHVybiByZXQ7CisKKwlkb3duKCZu
YW1lZF9vcHRfbGlzdF9tdXRleCk7CisKKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KG9wdCwgJm5hbWVk
X29wdF9saXN0LCBub2RlKSB7CisJCWlmIChzdHJjbXAob3B0LT5rb2JqLm5hbWUsIGlkKSA9PSAw
KSB7CisJCQltZF9vcHQgPSBvcHQtPnBvaW50LT5tZF9vcHQ7CisJCQlyZXQgPSAwOworCQkJYnJl
YWs7CisJCX0KKwl9CisKKwl1cCgmbmFtZWRfb3B0X2xpc3RfbXV0ZXgpOworCisJcmV0dXJuIHJl
dDsKK30KKworRVhQT1JUX1NZTUJPTF9HUEwocG93ZXJvcF9yZWdpc3Rlcl9uYW1lZF9wb2ludCk7
CitFWFBPUlRfU1lNQk9MX0dQTChwb3dlcm9wX3VucmVnaXN0ZXJfbmFtZWRfcG9pbnQpOworRVhQ
T1JUX1NZTUJPTF9HUEwocG93ZXJvcF9zZXRfbmFtZWRfcG9pbnQpOworRVhQT1JUX1NZTUJPTF9H
UEwocG93ZXJvcF9nZXRfbmFtZWRfcG9pbnQpOworCisvKiAKKyAqIHBvd2Vyb3Bfc2V0X3BvaW50
IC0gc3dpdGNoIHRoZSBzeXN0ZW0gdG8gbmV3IG9wZXJhdGluZyBwb2ludCAKKyAqCisgKiBJTlBV
VDoKKyAqICAgcG9pbnQgLSBvcGVyYXRpbmcgcG9pbnQgdG8gc2V0CisgKgorICogT1VUUFVUOgor
ICogICBub25lCisgKgorICogUkVUVVJOOgorICogICB6ZXJvIG9uIHN1Y2Nlc3MsIGVycm9yIGNv
ZGUgb3RoZXJ3aXNlCisgKgorICogTk9URVM6CisgKiAgIGtvYmogZmllbGQgb2YgJ3BvaW50JyBp
cyBpZ25vcmVkCisgKi8KK2ludAorcG93ZXJvcF9zZXRfcG9pbnQoc3RydWN0IHBvd2Vyb3BfcG9p
bnQgKnBvaW50KQoreworCWludCByYzsKKworCWRvd24oJnBvd2Vyb3BfbXV0ZXgpOworCXJjID0g
cG9pbnQgJiYgcG9pbnQtPm1kX29wdCAmJiBwb3dlcm9wX2RyaXZlciAmJiAKKyAgICAgICAgICAg
ICBwb3dlcm9wX2RyaXZlci0+c2V0X3BvaW50ID8gCisJCXBvd2Vyb3BfZHJpdmVyLT5zZXRfcG9p
bnQocG9pbnQtPm1kX29wdCkgOiAtRUlOVkFMOworCXVwKCZwb3dlcm9wX211dGV4KTsKKwkKKwly
ZXR1cm4gcmM7Cit9CisKKy8qIAorICogcG93ZXJvcF9nZXRfcG9pbnQgLSBnZXQgY3VycmVudCBv
cGVyYXRpbmcgcG9pbnQgdGhlIHN5c3RlbXMgaXMgCisgKiBydW5uaW5nIGF0IAorICoKKyAqIElO
UFVUOgorICogICBub25lCisgKgorICogT1VUUFVUOgorICogICBwb2ludCAtIGZpbGxlZCBpbiBw
b3dlciBwYXJhbWV0ZXIgdmFsdWVzCisgKgorICogUkVUVVJOOgorICogICB6ZXJvIG9uIHN1Y2Nl
c3MsIGVycm9yIGNvZGUgb3RoZXJ3aXNlCisgKgorICogTk9URVM6CisgKiAgIDEpIGNhbGxlciBt
dXN0IGFsbG9jYXRlIG1lbW9yeSBmb3IgbWRfb3B0IGZpZWxkIG9mICdwb2ludCcKKyAqICAgMikg
a29iaiBmaWVsZCBvZiAncG9pbnQnIGlzIHVuaW5pdGlhbGl6ZWQgb24gcmV0dXJuCisgKi8KK2lu
dAorcG93ZXJvcF9nZXRfcG9pbnQoc3RydWN0IHBvd2Vyb3BfcG9pbnQgKnBvaW50KQoreworCWlu
dCByYzsKKworCWlmIChwb2ludC0+bWRfb3B0ID09IE5VTEwpCisJCXJldHVybiAtRUlOVkFMOwor
CisJZG93bigmcG93ZXJvcF9tdXRleCk7CisJcmMgPSBwb2ludCAmJiBwb2ludC0+bWRfb3B0ICYm
IHBvd2Vyb3BfZHJpdmVyICYmIAorCSAgICAgcG93ZXJvcF9kcml2ZXItPmdldF9wb2ludCA/IAor
CQlwb3dlcm9wX2RyaXZlci0+Z2V0X3BvaW50KHBvaW50LT5tZF9vcHQpIDogLUVJTlZBTDsKKwl1
cCgmcG93ZXJvcF9tdXRleCk7CisKKwlyZXR1cm4gcmM7Cit9CisKK0VYUE9SVF9TWU1CT0xfR1BM
KHBvd2Vyb3Bfc2V0X3BvaW50KTsKK0VYUE9SVF9TWU1CT0xfR1BMKHBvd2Vyb3BfZ2V0X3BvaW50
KTsKKworc3RhdGljIGludCBfX2luaXQgcG93ZXJvcF9pbml0KHZvaWQpCit7CisJSU5JVF9MSVNU
X0hFQUQoJm5hbWVkX29wdF9saXN0KTsKKwlwb3dlcm9wX2luaXQgPSAxOworCisJcmV0dXJuIDA7
Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBwb3dlcm9wX2V4aXQodm9pZCkKK3sKKwlzdHJ1Y3Qg
bmFtZWRvcCAqb3B0LCAqdG1wX29wdDsKKworCWRvd24oJm5hbWVkX29wdF9saXN0X211dGV4KTsK
KworCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShvcHQsIHRtcF9vcHQsICZuYW1lZF9vcHRfbGlz
dCwgbm9kZSkgeworCQkJbGlzdF9kZWwoJm9wdC0+bm9kZSk7CisJCQlrZnJlZShvcHQpOworCX0J
CQorCisJdXAobmFtZWRfb3B0X2xpc3RfbXV0ZXgpOworfQorCittb2R1bGVfaW5pdChwb3dlcm9w
X2luaXQpOworbW9kdWxlX2V4aXQocG93ZXJvcF9leGl0KTsKKworTU9EVUxFX0RFU0NSSVBUSU9O
KCJQb3dlck9QIENvcmUiKTsKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKKwpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9wb3dlcm9wLmggYi9pbmNsdWRlL2xpbnV4L3Bvd2Vyb3AuaApuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4xYjFjMjMzCi0tLSAvZGV2L251bGwKKysrIGIv
aW5jbHVkZS9saW51eC9wb3dlcm9wLmgKQEAgLTAsMCArMSw0MyBAQAorLyoKKyAqIFBvd2VyT1Ag
Y29yZSBkZWZpbml0aW9ucworICoKKyAqIEF1dGhvcjogVG9kZCBQb3lub3IgPHRwb3lub3JAbXZp
c3RhLmNvbT4KKyAqIEludGVyZmFjZSB1cGRhdGUgYnkgRXVnZW55IFMuIE1pbnRzIDxldWdlbnku
bWludHNAZ21haWwuY29tPgorICoKKyAqIDIwMDUgKGMpIE1vbnRhVmlzdGEgU29mdHdhcmUsIElu
Yy4gVGhpcyBmaWxlIGlzIGxpY2Vuc2VkIHVuZGVyCisgKiB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMi4gVGhpcyBwcm9ncmFtCisgKiBpcyBsaWNl
bnNlZCAiYXMgaXMiIHdpdGhvdXQgYW55IHdhcnJhbnR5IG9mIGFueSBraW5kLCB3aGV0aGVyIGV4
cHJlc3MKKyAqIG9yIGltcGxpZWQuCisgKi8KKyNpZm5kZWYgX19QT1dFUk9QX0hfXworI2RlZmlu
ZSBfX1BPV0VST1BfSF9fCisKK3N0cnVjdCBwb3dlcm9wX3BvaW50IHsKKwlzdHJ1Y3Qga29iamVj
dCAga29iajsgICAvKiBob29rIHRvIHJlZmVyZW5jZSBhbiBvcGVyYXRpbmcgcG9pbnQgaW4KKwkJ
CQkgKiBzb21lIGFyY2ggaW5kZXBlbmRlbnQgd2F5CisJCQkJICovCisJdm9pZCAgICAgICAgICAg
Km1kX29wdDsgLyogYXJjaCBkZXBlbmRlbnQgc2V0IG9mIHBvd2VyIHBhcmFtZXRlcnMgKi8KK307
CisKK3N0cnVjdCBwb3dlcm9wX2RyaXZlciB7CisJY2hhciAqbmFtZTsKKwlpbnQgKCpzZXRfcG9p
bnQpKHZvaWQgKm1kX29wdCk7CisJaW50ICgqZ2V0X3BvaW50KSh2b2lkICptZF9vcHQpOworfTsK
KworLyogSW50ZXJmYWNlIHRvIGFuIGFyY2ggUE0gQ29yZSBsYXllciAqLworaW50IHBvd2Vyb3Bf
ZHJpdmVyX3JlZ2lzdGVyKHN0cnVjdCBwb3dlcm9wX2RyaXZlciAqcCk7Cit2b2lkIHBvd2Vyb3Bf
ZHJpdmVyX3VucmVnaXN0ZXIoc3RydWN0IHBvd2Vyb3BfZHJpdmVyICpwKTsKKworLyogSW50ZXJm
YWNlIHRvIGNvbnRyb2wvYWNjZXNzIG9wZXJhdGluZyBwb2ludHMgYnkgbmFtZSAqLworaW50IHBv
d2Vyb3BfcmVnaXN0ZXJfbmFtZWRfcG9pbnQoY29uc3QgY2hhciAqaWQsIHZvaWQgKm1kX29wdCk7
CitpbnQgcG93ZXJvcF91bnJlZ2lzdGVyX25hbWVkX3BvaW50KGNvbnN0IGNoYXIgKmlkKTsKK2lu
dCBwb3dlcm9wX3NldF9uYW1lZF9wb2ludChjb25zdCBjaGFyICppZCk7CitpbnQgcG93ZXJvcF9n
ZXRfbmFtZWRfcG9pbnQoY29uc3QgY2hhciAqaWQsIHZvaWQgKm1kX29wdCk7CisKKy8qIERpcmVj
dCBpbnRlcmZhY2UgdG8gc2V0L2dldCBvcGVyYXRpbmcgcG9pbnRzICovCitpbnQgcG93ZXJvcF9z
ZXRfcG9pbnQocG93ZXJvcF9wb2ludCAqb3B0KTsKK2ludCBwb3dlcm9wX2dldF9wb2ludChwb3dl
cm9wX3BvaW50ICpvcHQpOworCisjZW5kaWYgLyogX19QT1dFUk9QX0hfXyAqLworCg==
------=_Part_8229_213442.1154570834683
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


------=_Part_8229_213442.1154570834683--
