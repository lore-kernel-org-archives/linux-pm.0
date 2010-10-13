From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 13/23] Hibernation: Partial page I/O support.
Date: Wed, 13 Oct 2010 09:10:08 +0200
Message-ID: <20101013071008.GA1610__42551.618620246$1286975277$gmane$org@ucw.cz>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-14-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1285566238-10966-14-git-send-email-nigel@tuxonice.net>
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

Hi!

> Add functions that can be used for coalescing and splitting buffers
> that are smaller than PAGE_SIZE. These functions provide no method
> of determining where the boundaries of the smaller buffers are to
> be found - that is the caller's problem.

I don't get it; why do we need that support?


> +int hib_write_buffer(char *buffer, int buffer_size)
> +{
> +	int bytes_left = buffer_size, result = 0;
> +
> +	while (bytes_left) {
> +		char *from = buffer + buffer_size - bytes_left;
> +		char *to = hib_ppio_buffer + hib_ppio_buffer_posn;
> +		int capacity = PAGE_SIZE - hib_ppio_buffer_posn;
> +
> +		if (bytes_left <= capacity) {
> +			memcpy(to, from, bytes_left);
> +			hib_ppio_buffer_posn += bytes_left;
> +			return 0;
> +		}
> +
> +		/* Complete this page and start a new one */
> +		memcpy(to, from, capacity);
> +		bytes_left -= capacity;

If this copy happens too often, it will slow stuff down...
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
