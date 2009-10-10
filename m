From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] PM / Hibernate: fix error handling in
	save_image
Date: Sat, 10 Oct 2009 14:17:23 +0200
Message-ID: <20091010121723.GC1943@ucw.cz>
References: <1255175505-7756-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1255175505-7756-1-git-send-email-jirislaby@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat 2009-10-10 13:51:45, Jiri Slaby wrote:
> There are too many retval variables in save_image. Thus error return
> value from snapshot_read_next may be ignored and only part of the
> snapshot (successfully) written.
> 
> Remove 'error' variable, invert the condition in the do-while loop
> and convert the loop to use only 'ret' variable.
> 
> Switch the rest of the function to consider only 'ret'.
> 
> Also make sure we end printed line by \n if an error occurs.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
