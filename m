From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.33-rc1 regression] suspend doesn't work on X200s
Date: Sun, 27 Dec 2009 22:02:50 +0100
Message-ID: <200912272202.50897.rjw__1987.13494833118$1261947866$gmane$org@sisk.pl>
References: <cb0375e10912211645w1fecfafcj8f1c0ab9ce23b077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <cb0375e10912211645w1fecfafcj8f1c0ab9ce23b077@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 22 December 2009, Andrew Lutomirski wrote:
> Hi all-
> 
> On Linus's tree from yesterday (2.6.33-rc1 plus a bit, I think) with
> drm-next patched in, I can't suspend.  My sleep light starts blinking
> (userspace does that, I think) and the screen goes blank, then the
> caps lock and num lock lights blink once (this is supposed to happen
> when suspending), and then the system freezes hard with the fan and
> backlight still on and the suspend light still blinking.
> 
> I'm pretty sure this has nothing to do with drm changes, since I can
> suspend fine on 2.6.32.1 with include/drm and drivers/drm copied from
> the broken 2.6.33-rc1 + drm-next tree.

I've created a Bugzilla entry for your report at
http://bugzilla.kernel.org/show_bug.cgi?id=14887

Please put your hardware information in there.

Rafael
