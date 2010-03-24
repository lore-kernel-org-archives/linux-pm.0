From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 03/15] PM / Hibernate: separate block_io
Date: Wed, 24 Mar 2010 21:30:21 +0100
Message-ID: <20100324203021.GE5798__10401.1239870035$1269462833$gmane$org@elf.ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-3-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269361063-3341-3-git-send-email-jslaby@suse.cz>
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

On Tue 2010-03-23 17:17:31, Jiri Slaby wrote:
> Move block I/O operations to a separate file. It is because it will
> be used later not only by the swap writer.

So... what is the plan here?

> +int sws_bio_read_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
> +{
> +	return submit(READ, sws_resume_bdev, page_off * (PAGE_SIZE >> 9),
> +			virt_to_page(addr), bio_chain);
> +}

sws_ is kind of strange prefix. We were trying to get away from
"swsuspend" name for quite some time...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
