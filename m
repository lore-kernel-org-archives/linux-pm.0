From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH/RFC] platform_bus: Allow runtime PM by default
Date: Sun, 28 Mar 2010 00:32:00 +0100
Message-ID: <201003280032.01011.rjw__42976.1753337972$1269732620$gmane$org@sisk.pl>
References: <1269625370-17754-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201003262335.06941.rjw@sisk.pl>
	<251AAFA3-F44D-40D2-BF99-E82EE58FD52D@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <251AAFA3-F44D-40D2-BF99-E82EE58FD52D@opensource.wolfsonmicro.com>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 27 March 2010, Mark Brown wrote:
> On 26 Mar 2010, at 22:35, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Friday 26 March 2010, Mark Brown wrote:
> >> Currently the default runtime PM callbacks for platform devices  
> >> return
> >> -ENOSYS, preventing the use of runtime PM platforms until they have
> >> provided at least a default implementation. This hinders the use of
> >> runtime PM by devices which work with many platforms such as memory
> >> mapped devices, MFDs and on chip IPs shared by multiple  
> >> architectures.
> >>
> >> Change the default implementation to the standard pm_generic_runtime
> >> one, allowing drivers to use runtime PM without per-architecture
> >> changes.
> >>
> >> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >
> > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Is it very urgent?
> 
> Not especially - worst case you just don't get devices suspending  
> which isn't the end of the world and there's no build time  
> dependencies introduced.

OK, so I guess it will be sufficient if Greg queues it for .35.

Rafael
