From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 12:49:26 +0100
Message-ID: <20090202114926.GD4631@elf.ucw.cz>
References: <d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
	<Pine.LNX.4.44L0.0901292203470.4063-100000@netrider.rowland.org>
	<d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
	<d6200be20901292204i207f5c89u37825ea8dd6bd843@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20901292204i207f5c89u37825ea8dd6bd843@mail.gmail.com>
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
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> User-space API
> ==============
> 
> Write "lockname" or "lockname timeout" to /sys/power/wake_lock lock and if
> needed create a wakelock. The timeout here is specified nanoseconds.
> Write "lockname" to /sys/power/wake_unlock to unlock a user wakelock.
> 
> Do not use randomly generated wakelock names as there is no api to free
> a user-space wakelock.

Do you have some examples of user wakelocks?

The API is quite ugly; creating objects by writing to file.

If userspace does not want system to suspend, could it simply write
"on" to /sys/power/state ?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
