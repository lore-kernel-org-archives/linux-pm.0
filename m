From: Oliver Neukum <oliver@neukum.org>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 10 Feb 2010 12:02:54 +0100
Message-ID: <201002101202.54557.oliver@neukum.org>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201002101138.47072.oliver@neukum.org>
	<201002101158.22606.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002101158.22606.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 10. Februar 2010 11:58:22 schrieb Rafael J. Wysocki:
> On Wednesday 10 February 2010, Oliver Neukum wrote:
> > Am Mittwoch, 10. Februar 2010 11:34:23 schrieb Rafael J. Wysocki:
> > > Actually, doing the sync() in the kernel is a hack that we decided not to
> > > remove just because the users space didin't do the right thing on some systems.
> > > If the user space always synced disks before suspending, we wouldn't have to
> > > do that in the kernel.
> > 
> > If you sync in user space will you not have an inevitable race condition?
> 
> Do you mean the race with applications that write to disks while the sustem is
> suspending?

Yes.

	Regards
		Oliver
