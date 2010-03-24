From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 07/15] PM / Hibernate: add sws_modules_ops
Date: Wed, 24 Mar 2010 21:36:34 +0100
Message-ID: <20100324203634.GH5798__34481.3579730273$1269463105$gmane$org@elf.ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-7-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269361063-3341-7-git-send-email-jslaby@suse.cz>
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

On Tue 2010-03-23 17:17:35, Jiri Slaby wrote:
> For now they will only hold swap operations. In next patches, user
> support will be converted to ops as well to have a single layer and
> can push pages instead of pulling them.

> +struct sws_module_ops {
> +	unsigned long (*storage_available)(void);
> +
> +	int (*get_reader)(unsigned int *flags_p);
> +	int (*put_reader)(void);
> +	int (*get_writer)(void);
> +	int (*put_writer)(unsigned int flags, int error);
> +	int (*read_page)(void *addr, struct bio **bio_chain);
> +	int (*write_page)(void *addr, struct bio **bio_chain);
> +};

sws_ prefix is strange.

Plus, could we get some docs what it does? Stuff like "get_writer" is
not entirely self-documenting.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
