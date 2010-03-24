From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Wed, 24 Mar 2010 21:42:59 +0100
Message-ID: <20100324204259.GA6423__31023.2656811879$1269463752$gmane$org@elf.ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-9-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269361063-3341-9-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Switch /dev/snapshot writer to sws_module_ops approach so that we
> can transparently rewrite the rest of the snapshot from pages pulling
> to their pushing through layers.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---
>  kernel/power/user.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 105 insertions(+), 8 deletions(-)
>

> +	if (test_bit(TODO_CLOSED, to_do_flags))
> +		return -EIO;
> +
> +	to_do_buf = buf;
> +	wmb();
> +	set_bit(TODO_WORK, to_do_flags);
> +	wake_up_interruptible(&to_do_wait);

Uhuh, open-coded barriers... these need to be commented, and I guess
you just should not play this kind of trickery.

spnlocks? Normal locks?

> +
> +	wait_event(to_do_done, !test_bit(TODO_WORK, to_do_flags) ||
> +			(err = test_bit(TODO_CLOSED, to_do_flags)));
> +
> +	return err ? -EIO : 0;
> +}
> +
> +static int put_user_writer(unsigned int flags, int error)
> +{
> +	int err = 0;
> +
> +	if (error)
> +		set_bit(TODO_ERROR, to_do_flags);
> +	set_bit(TODO_FINISH, to_do_flags);
> +	wake_up_interruptible(&to_do_wait);
> +
> +	wait_event(to_do_done, !test_bit(TODO_FINISH, to_do_flags) ||
> +			(err = test_bit(TODO_CLOSED, to_do_flags)));
> +
> +	if (!error && err)
> +		error = -EIO;
> +
> +	return error;
> +}
> +
>  struct sws_module_ops user_ops = {
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
