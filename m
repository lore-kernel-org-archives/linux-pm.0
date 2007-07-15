From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 00:38:11 +0200
Message-ID: <200707160038.12943.rjw__41118.9318438575$1184538681$gmane$org@sisk.pl>
References: <200707151433.34625.rjw@sisk.pl> <20070715125855.GA1737@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070715125855.GA1737@gallifrey>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 15 July 2007 14:58, Dr. David Alan Gilbert wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> 
> > (5) Hibernation should be transparent from the applications' point of view
> > 
> >     Generally, applications should not notice that hibernation took place.
> >     [Note that I don't regard all processes as applications and I think that
> >     there may be processes which need to handle the hibernation in a special
> >     way.]  Ideally, for example, if some audio is being played when a
> >     hibernation starts, the audio player should be able to continue playing the
> >     same audio after the restore from the point in which it has been
> >     interrupted by the hibernation.  Also, the CPU affinities and similar
> 
> That would be _so_ embarrassing in a library; I'd rather the audio
> player had the opportunity to consider whether restarting was a good idea.
> 
> > (6) State of devices from before hibernation should be restored, if possible
> > 
> >     If possible, during a restore devices should be brought back to the same
> >     state in which they were before the corresponding hibernation.  Of course
> >     in some situations it might be impossible to do that (eg. the user
> >     connected the hibernated system to a different IP subnet and then
> >     restored), but as a general rule, we should do our best to restore the
> >     state of devices, which is directly related to point (5) above.
> 
> Or the user unplugs their flash drive after hibernation rather than before.
> 
> Two things which I think would be nice to consider are:
>    1) Encryption - I'd actually prefer if my luks device did not
>        remember the key accross a hibernation; I want to be forced to
>        reenter the phrase.  However I don't know what the best thing
>        to do to partitions/applications using the luks device is.

Encryption is possible with both the userland hibernation (aka uswsusp) and
TuxOnIce (formerly known as suspend2).  Still, I don't consider it as a "must
have" feature for a framework to be generally useful (many users don't use it
anyway).

>    2) Some level of debugging needs to be available so that users can
>       provide something so you can see why something hasn't hibernated
>       or why (as in the case of this tosh laptop) it still takes power
>       during hibernation.

I agree.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
