From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V2
Date: Wed, 3 Jun 2009 11:01:55 +0200
Message-ID: <200906031101.56577.rjw__29381.2756347053$1244019755$gmane$org@sisk.pl>
References: <20090601101614.10720.93804.sendpatchset@rx1.opensource.se>
	<200906012133.32074.rjw@sisk.pl>
	<aec7e5c30906012133w74d7d843jccad99c564a308ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906012133w74d7d843jccad99c564a308ec@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 June 2009, Magnus Damm wrote:
> 2009/6/2 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Monday 01 June 2009, Rafael J. Wysocki wrote:
> >> On Monday 01 June 2009, Magnus Damm wrote:
> >> > From: Magnus Damm <damm@igel.co.jp>
[--snip--]
> 
> If you guys dislike adding arch specific data to struct platform
> device then for SuperH we can just (mis)use the arch specific data in
> struct device instead. I'm afraid that solution wastes memory since
> the data will only be used for platform devices anyway. So I prefer
> adding arch specific data to struct platform_device instead of struct
> device if possible.

BTW, what is the difference really?  You can always put
dev.platform_data = NULL for devices that don't have any platform data,
can't you?

Rafael
