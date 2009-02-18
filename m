From: mark gross <mgross@linux.intel.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 16:27:04 -0800
Message-ID: <20090218002704.GB25605__20561.8271757432$1234916776$gmane$org@linux.intel.com>
References: <200902160010.16955.rjw@sisk.pl>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902160010.16955.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 16, 2009 at 12:10:15AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> The recent descussion about the Android PM patches sent by Arve shows that
> there is a need to introduce a mechanism allowing us to:
> (1) automatically put the system as a whole into a sleep state (eg. suspend to
>     RAM) when it is found to be "idle", where the meaning of "idle" has to be
>     defined too,

Can a fast STR state be created for the generic kernel across
architectures?  Something that can go into and out of SRT in < 20ms? (I
picked 20ms as that gives 50Hz screen refresh) I guess the XO does
something like this between keystrokes. 

Note: I don't know (but I should) if such a PM design popping into and
out of STR at worst every 20ms is worth doing on IA but lets assume its
not so bad for the sake of argument.

One could assume the system would be idle except for selects on HID
events when operating in this mode.

> (2) put given subset of devices into low power states whenever they are not
>     used, without putting the entire system into a sleep state.

This is a driver deal to drop the hardware they control into lower power
states.  Give information for PM-QOS the drivers could do the right
things here.  (or should be able too) 


Also how do we attempt to coordinate this with an automatic STR state?

How to coexist with user requested STR?

Do we need to more carefully define what STR really means?  (I'm
thinking we do)


> To allow these two things to happen, the Andriod patches introduced the
> wakelocks with the associated infrastructure and the "early suspend" mechanism.
> However, quite a number of reviewers did not like these patches, for various
> reasons, so they cannot be regarded as generally acceptable.  For this reason,
> I think, we should discuss the problem in detail from the beginning and try to
> find a solution that everyone interested will be comfortable with.
> 
> For this purpose, IMO, we should at least reach an agreement on what the
> kernel's and the userland's roles in (1) and (2) are going to be.  There also
> are quite a few questions that need to be answered.  For instance, what
> conditions are going to be used to decide whether or not the system is idle
> enough so that we can put it into a sleep state?  How are we going to check
> these conditions?  What is going to happen if one (or more) of them changes
> while a system-wide power transition (eg. suspend) is in progress?  Are we
> going to allow the user space to take part in this and if so, to what extent?
> What mechanisms are going be used to put devices into low power states at run
> time (ie. before starting any system-wide power transition) and how are they
> going to be related to the suspend-resume infrastructure used during
> system-wide power transitions?  The answers to these (and other related)
> questions will likely affect all of the future Linux PM developlent, so IMO
> this is a very important matter.
> 
> Opinions and comments welcome.
>

thank you for starting this FRD.
 
--mgross
> Thanks,
> Rafael
