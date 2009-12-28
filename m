From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: kernel 2.6.32 much slower than 2.6.31 on s2disk
Date: Mon, 28 Dec 2009 23:56:26 +0100
Message-ID: <200912282356.26815.rjw@sisk.pl>
References: <hgb0q7$u8a$1@ger.gmane.org> <200912272156.27174.rjw@sisk.pl>
	<4B386B89.6000506@wm1.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B386B89.6000506@wm1.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Willi Mann <foss-ml@wm1.at>
Cc: linux-pm@lists.linux-foundation.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday 28 December 2009, Willi Mann wrote:
> 
> >> I don't know to how to do a reliable benchmark on this problem, espially as 
> >> the required time probably very much depends on the exact state of the 
> >> frozen system. Is there any change in 2.6.32 that might cause less memory to 
> >> be stored on the suspend device, and thus require more random disk access 
> >> after the restore?
> > 
> > Actaully, yes, there is.
> > 
> > Please try to increase the value in /sys/power/image_size to approximately
> > 1/2 of your RAM and report back (the number is in bytes).
> 
> Without changing the image_size, it especially got much better when I
> downgraded QT 4.6 to QT 4.5 which does not work well with KDE 4.3 (seems
> to cause memleaks).
> 
> However, image_size is already set to your recommended value (well,
> approximately):
> 
> # cat /sys/power/image_size
> 951431086
> 
> My RAM size is 2 GB (however, I have intel graohics with shared mem, so
> some part is reserved), my swap size is a little bit more than 2 GB.
> 
> I don't know what value image_size was set to when I tried first.
> 
> Note that when I reported the issue first I used Debian kernel 2.6.32-1,
> (probably plain 2.6.32), while I'm now using Debian kernel 2.6.32-2
> (according to the changelog 2.6.32.1)

So, is it still a problem for you?

Rafael
