From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 6 May 2010 00:09:17 +0100
Message-ID: <20100505230917.GA5269__2598.05283644727$1273101010$gmane$org@opensource.wolfsonmicro.com>
References: <20100505185225.GA4411@srcf.ucam.org>
	<201005052244.03225.rjw@sisk.pl>
	<20100505215711.GA4838@opensource.wolfsonmicro.com>
	<201005060005.01215.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005060005.01215.rjw@sisk.pl>
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
Cc: Paul Walmsley <paul@pwsan.com>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 06, 2010 at 12:05:01AM +0200, Rafael J. Wysocki wrote:

> So, gnerenally, we may need a mechanism to specify which components of the
> system need to stay powered while the whole system is suspended (in addition to
> wakeup devices, that is).

> That certainly I can agree with.

> I'm not sure, however, in what way this is relevant to the $subject patchset.

The patch set essentially makes using a full system suspend as the
lowest power state for runtime PM part of the standard Linux power
management toolkit which means that it's no longer clear as it used to
be that suspend is an instruction to cease all activity and go into a
minimal power state if the device is not a wake source.  In the primary
existing application this change interoperates very poorly with at least
the current audio subsystem since that handles suspend by ceasing all
activity and powering as much as it can off, which is sensible for
manual only suspends but highly undesirable for opportunistic suspend in
phones.  We should therefore have some idea how this and any other
affected areas are supposed to work.

As I said in my reply to Ted earlier I think we may actually be
converging on not worrying too much about it at the global level and
doing subsystem specific things to discover and handle affected cases,
at least for the time being.  Ideally we'd have something standard to
hook into but no subsystems apart from audio have actually been
identified as being affected so it's not clear to me that a general
solution is going to be worth the effort, if there's no actual users it
may just confuse people by adding yet more power managment stuff to
learn.
