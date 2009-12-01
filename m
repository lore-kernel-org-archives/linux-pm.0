From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v6 7/8] Loongson: YeeLoong: add suspend driver
Date: Tue, 1 Dec 2009 15:18:05 +0000
Message-ID: <20091201151805.GA23019__36814.0858052813$1259680748$gmane$org@linux-mips.org>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
	<2574dde59f2e54ef9fa80423a7f02ed32eab7ab4.1259664573.git.wuzhangjin@gmail.com>
	<200912011324.29486.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912011324.29486.rjw@sisk.pl>
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
Cc: linux-mips@linux-mips.org, linux-pm@lists.linux-foundation.org, zhangfx@lemote.com
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 01, 2009 at 01:24:29PM +0100, Rafael J. Wysocki wrote:

> On Tuesday 01 December 2009, Wu Zhangin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds Suspend Driver, which will suspend the YeeLoong Platform
> > specific devices.
> > 
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> I'm still not sure how useful it is to build it as a module, but otherwise

I think I agree with that.  Maybe even one step further and just build
this code depending on CONFIG_PM or similar?

  Ralf
