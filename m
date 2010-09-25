From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/22] Hibernation: Switch to preallocating
	swap.
Date: Sun, 26 Sep 2010 00:22:36 +0200
Message-ID: <201009260022.36244.rjw__14712.1233320378$1285453573$gmane$org@sisk.pl>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
	<201009252324.39445.rjw@sisk.pl> <4C9E6A75.8090702@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C9E6A75.8090702@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, September 25, 2010, Nigel Cunningham wrote:
> Morning.
> 
> On 26/09/10 07:24, Rafael J. Wysocki wrote:
> > On Saturday, September 25, 2010, Nigel Cunningham wrote:
> >> Switch from allocating swap as the image is written to allocating
> >> storage prior to writing the image.
> >
> > Hmm, I think I know what the patch does, but I don't really understand the
> > changelog.  Care to explain/fix?
> 
> Sure. I was a little terse, wasn't I? :)
> 
> Prior to this patch, we allocated swap as we were writing the image. 
> This patch changes things so that we instead allocate all the swap we'll 
> need prior to starting to write the image. It lays groundwork for later 
> patches that switch from doing I/O in batches.

Good.  I'll use the above as a replacement changelog if you don't mind.

Thanks,
Rafael
