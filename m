From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 10:26:28 +0800
Message-ID: <1205288788.29875.28.camel__47011.5763870583$1205289009$gmane$org@caritas-dev.intel.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>  <200803112318.28120.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803112318.28120.rjw@sisk.pl>
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

On Tue, 2008-03-11 at 23:18 +0100, Rafael J. Wysocki wrote:
> On Tuesday, 11 of March 2008, Vivek Goyal wrote:
[...]
> > Rafael/Pavel, does the approach of doing hibernation using a separate
> > kernel holds promise?
> 
> Well, what can I say?
> 
> I haven't been a big fan of doing hibernation this way since the very beginning
> and I still have the same reservations.  Namely, my opinion is that the
> hibernation-related problems we have are not just solvable this way.  For one
> example, in order to stop using the freezer for suspend/hibernation we first
> need to revamp the suspending/resuming of devices (uder way) and the
> kexec-based approach doesn't help us here.  I wouldn't like to start another
> discussion about it though.

Yes. We need to work on device drivers for all hibernation
implementations. And kexec-based hibernation provides a possible method
to avoid freezer after driver works done.

Best Regards,
Huang Ying
