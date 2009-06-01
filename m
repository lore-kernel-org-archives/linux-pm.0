From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][RFC] pm: remove device_type
	suspend()/resume()
Date: Tue, 2 Jun 2009 00:47:28 +0200
Message-ID: <200906020047.29119.rjw@sisk.pl>
References: <20090601103836.10959.43392.sendpatchset@rx1.opensource.se>
	<200906012040.58290.rjw@sisk.pl> <20090601210224.GA2236@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090601210224.GA2236@suse.de>
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
To: Greg KH <gregkh@suse.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 01 June 2009, Greg KH wrote:
> On Mon, Jun 01, 2009 at 08:40:57PM +0200, Rafael J. Wysocki wrote:
> > On Monday 01 June 2009, Magnus Damm wrote:
> > > From: Magnus Damm <damm@igel.co.jp>
> > > 
> > > This patch removes the legacy callbacks ->suspend() and
> > > ->resume() from struct device_type. These callbacks seem
> > > unused, and new code should instead make use of struct
> > > dev_pm_ops.
> > > 
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > 
> > This is fine by me.
> > 
> > Greg, Pavel, Alan, any objections?
> 
> Nope:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Great, thanks!

if you don't mind, I'm going to take it to my tree.

Best,
Rafael
