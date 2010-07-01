From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Runtime PM status sysfs attribute
Date: Thu, 1 Jul 2010 20:54:38 +0200
Message-ID: <20100701185438.GA22352@isilmar-3.linta.de>
References: <Pine.LNX.4.44L0.1007011312580.1303-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan,

On Thu, Jul 01, 2010 at 01:16:31PM -0400, Alan Stern wrote:
> As runtime PM becomes more and more popular, it seems likely that 
> people will want to know whether or not their devices are getting 
> suspended.  Or if not people, then programs like powertop.
> 
> For that reason, it seems to make sense to build the runtime_status
> sysfs attribute even when CONFIG_PM_ADVANCED_DEBUG isn't enabled.  Do
> you agree?

good idea; haven't looked at any dependencies yet, though...

Best,
	Dominik
