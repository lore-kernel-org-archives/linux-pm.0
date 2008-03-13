From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 18:33:21 -0600
Message-ID: <m1iqzrxy26.fsf__15199.4824213491$1205368778$gmane$org@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.44L0.0803121055510.4595-100000@iolanthe.rowland.org>
	<200803122253.07631.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803122253.07631.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Wed, 12 Mar 2008 22:53:06 +0100")
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Yes, it ought to be possible.
>
> Ultimately, IMHO, we should put all devices unnecessary for saving the image
> (and doing some eye-candy work) into low power states before the image is
> created and keep them in low power states until the system is eventually
> powered off.

Why?  I guess I don't see why we care what power state the devices are in.
Especially since we should be able to quickly save the image.

We need to disconnect the drivers from the hardware yes.  So filesystems
still work and applications that do direct hardware access still work
and don't need to reopen their connections.

I'm leery of low power states as they don't always work, and bringing
low power states seems to confuse hibernation to disk with suspend to
ram.

> If this is done, the remaining problem is the handling of the devices that we
> need to save the image.  I believe that will be achievable without using the
> freezer.

Reasonable.  In general the problem is much easier if we don't store
the hibernation image in a filesystem or partition that the rest of
the system is using.  That way we avoid inconsistencies.

Eric
