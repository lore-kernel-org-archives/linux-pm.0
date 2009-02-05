From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 12/13] Input: Hold wake lock while event
	queue is not	empty.
Date: Thu, 5 Feb 2009 10:08:04 +0100
Message-ID: <20090205090804.GF2077@elf.ucw.cz>
References: <1233802226-23386-4-git-send-email-arve@android.com>
	<1233802226-23386-5-git-send-email-arve@android.com>
	<1233802226-23386-6-git-send-email-arve@android.com>
	<1233802226-23386-7-git-send-email-arve@android.com>
	<1233802226-23386-8-git-send-email-arve@android.com>
	<1233802226-23386-9-git-send-email-arve@android.com>
	<1233802226-23386-10-git-send-email-arve@android.com>
	<1233802226-23386-11-git-send-email-arve@android.com>
	<1233802226-23386-12-git-send-email-arve@android.com>
	<1233802226-23386-13-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-13-git-send-email-arve@android.com>
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

On Wed 2009-02-04 18:50:25, Arve Hj??nnev??g wrote:
> Allows userspace code to process input events while
> the device appears to be asleep.

...

> @@ -55,6 +57,7 @@ static void evdev_pass_event(struct evdev_client *client,
>  	 * Interrupts are disabled, just acquire the lock
>  	 */
>  	spin_lock(&client->buffer_lock);
> +	wake_lock_timeout(&client->wake_lock, 5 * HZ);
>  	client->buffer[client->head++] = *event;
>  	client->head &= EVDEV_BUFFER_SIZE - 1;
>  	spin_unlock(&client->buffer_lock);

...as long as userspace needs less than 5 seconds. Ugly hack.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
