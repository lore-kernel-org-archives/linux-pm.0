From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Runtime PM status sysfs attribute
Date: Fri, 2 Jul 2010 07:34:58 +0200
Message-ID: <201007020734.58917.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1007011312580.1303-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007011312580.1303-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 1. Juli 2010, 19:16:31 schrieb Alan Stern:
> Dominik:
> 
> As runtime PM becomes more and more popular, it seems likely that 
> people will want to know whether or not their devices are getting 
> suspended.  Or if not people, then programs like powertop.
> 
> For that reason, it seems to make sense to build the runtime_status
> sysfs attribute even when CONFIG_PM_ADVANCED_DEBUG isn't enabled.  Do
> you agree?

For what it's worth, I think this is a good idea.

	Regards
		Oliver
