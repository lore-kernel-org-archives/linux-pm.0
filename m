From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sun, 8 Feb 2009 22:30:05 +0100
Message-ID: <20090208213005.GH6369@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205091132.GG2077@elf.ucw.cz>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
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

On Thu 2009-02-05 16:28:28, Arve Hj?nnev?g wrote:
> On Thu, Feb 5, 2009 at 1:11 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Wed 2009-02-04 18:50:14, Arve Hj??nnev??g wrote:
> >> +A locked wakelock, depending on its type, prevents the system from entering
> >> +suspend or other low-power states. When creating a wakelock, you can select
> >> +if it prevents suspend or low-power idle states.  If the type is
> >> set to
> >
> > idle states are very different from suspend. Mixing them does not look
> > like good idea... and IIRC we already have API somewhere to prevent
> > deep idle states. Intel did it for their wireless cards IIRC.
> 
> If you are talking about the pm_qos interface, then yes there is some
> overlap. We did not use the pm_qos interface since it does a linear
> scan for a string every time you change a requirement, and it only
> let

If pm_qos code is too slow for you, just fix it! 

> you specify the latency you need not the power level. We have
> interrupts that stop working at the lowest power level and this does
> not easily translate into a latency value.

Could clock framwork be used for this? 

Or maybe you just want to prevent low idle states as long as those
interrupts are claimed, no new api needed?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
