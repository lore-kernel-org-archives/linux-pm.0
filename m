From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 09/13] PM: wakelock: Abort task freezing if a
	wake lock	is held.
Date: Thu, 5 Feb 2009 10:49:33 +0100
Message-ID: <20090205094932.GL2077@elf.ucw.cz>
References: <1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<20090205085531.GC2077@elf.ucw.cz>
	<d6200be20902050130q73d710foabb5d1a331f1528b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902050130q73d710foabb5d1a331f1528b@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu 2009-02-05 01:30:35, Arve Hj?nnev?g wrote:
> On Thu, Feb 5, 2009 at 12:55 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> Avoids a problem where the device sometimes hangs for 20 seconds
> >> before the screen is turned on.
> >
> > Fix the problem rather than working around it.
> 
> We used to have problems where if a process was connected to a
> debugger, and the debugger was frozen first, the this code would be
> stuck until it times out. I have not seen this problem recently, but
> aborting as soon as you know that you should wake up is still good.

Can you explain why you need the change in the changelog then? It is
not at all clear to me.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
