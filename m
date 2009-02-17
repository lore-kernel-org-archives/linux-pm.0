From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions (version 3)
Date: Tue, 17 Feb 2009 22:05:04 +0100
Message-ID: <20090217210504.GD1433@ucw.cz>
References: <1234316955-31304-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1234316955-31304-1-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> The following patch series adds two apis, wakelock and earlysuspend.
> The Android platform uses the earlysuspend api to turn the screen
> and some input devices on and off. The wakelock code determines when
> to enter the full suspend state.

earlysuspend is an ugly hack and wakelock is very wrong name at the
very least... as seen in previous discussion. Can we get that fixed?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
