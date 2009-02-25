From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions (version 3)
Date: Wed, 25 Feb 2009 14:23:53 +0100
Message-ID: <20090225132353.GA5109@atrey.karlin.mff.cuni.cz>
References: <1234316955-31304-1-git-send-email-arve@android.com>
	<20090217210504.GD1433@ucw.cz>
	<d6200be20902181743i1bb36fe8m95b50c0fbd6d3c2@mail.gmail.com>
	<20090222134852.GB1436@ucw.cz>
	<d6200be20902231531r75f8ee05o1f512d1636710c3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902231531r75f8ee05o1f512d1636710c3d@mail.gmail.com>
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

Hi!

> There is no requirement for the kernel api to match the user-space
> api, it is just less confusing. The android java apis provide a
> wakelock interface. We cannot change this api, but the both the in
> kernel api and the api from the kernel to user space can be changed.
> 
> I did a quick poll here. 2 people preferred suspend_inhibitor and 3
> people preferred wake_lock. The people who preferred wake_lock did not
> like the word inhibit(or). Block(er) was suggested as an alternative.

suspend_block / suspend_unblock sounds fine to me.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
