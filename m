From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 04/15] PM / Hibernate: move the first_sector
 out of swsusp_write
Date: Wed, 24 Mar 2010 21:31:25 +0100
Message-ID: <20100324203125.GF5798__11726.4552427971$1269462964$gmane$org@elf.ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-4-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1269361063-3341-4-git-send-email-jslaby@suse.cz>
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

On Tue 2010-03-23 17:17:32, Jiri Slaby wrote:
> From: Jiri Slaby <jirislaby@gmail.com>
> 
> The first sector knowledge is swap only specific. Move it into the
> handle. This will be needed for later non-swap specific code moving
> inside snapshot.c.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Seems ok. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
