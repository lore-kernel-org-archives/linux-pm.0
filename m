From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 6 May 2010 01:33:59 +0200
Message-ID: <201005060133.59417.rjw__812.417714814906$1273102501$gmane$org@sisk.pl>
References: <20100505185225.GA4411@srcf.ucam.org>
	<201005060005.01215.rjw@sisk.pl>
	<20100505230917.GA5269@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505230917.GA5269@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 06 May 2010, Mark Brown wrote:
> On Thu, May 06, 2010 at 12:05:01AM +0200, Rafael J. Wysocki wrote:
> 
> > So, gnerenally, we may need a mechanism to specify which components of the
> > system need to stay powered while the whole system is suspended (in addition to
> > wakeup devices, that is).
> 
> > That certainly I can agree with.
> 
> > I'm not sure, however, in what way this is relevant to the $subject patchset.
> 
> The patch set essentially makes using a full system suspend as the
> lowest power state for runtime PM part of the standard Linux power
> management toolkit which means that it's no longer clear as it used to
> be that suspend is an instruction to cease all activity and go into a
> minimal power state if the device is not a wake source.

I don't see why, really.  This patchset doesn't change the meaning of suspend
at all, it only changes the way in which suspend is triggered (if specifically
set up that way).  Even without the patchset you may implement a power
manager in user space that will suspend the system whenever it thinks it's
idle.

> In the primary existing application this change interoperates very poorly
> with at least the current audio subsystem since that handles suspend by
> ceasing all activity and powering as much as it can off, which is sensible for
> manual only suspends but highly undesirable for opportunistic suspend in
> phones.

You said that there's no fundamental difference between manual and
opportunistic suspend.  It only matters what _you_ are going to use suspend
for.  I agree that at the moment it's not suitable for aggressive power
management in phones because of the audio problem, but that applies to
"manual" as well as to "opportunistic" suspend.

You're saying that suspend is not suitable for one particular purpose in its
current form, which is entirely correct, but that doesn't imply that the
patchset is wrong.

Rafael
