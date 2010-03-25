From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 04/15] PM / Hibernate: move the first_sector
	out of swsusp_write
Date: Thu, 25 Mar 2010 22:26:48 +0100
Message-ID: <201003252226.48599.rjw__44108.3730584525$1269552371$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-4-git-send-email-jslaby@suse.cz>
	<20100324203125.GF5798@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100324203125.GF5798@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 24 March 2010, Pavel Machek wrote:
> On Tue 2010-03-23 17:17:32, Jiri Slaby wrote:
> > From: Jiri Slaby <jirislaby@gmail.com>
> > 
> > The first sector knowledge is swap only specific. Move it into the
> > handle. This will be needed for later non-swap specific code moving
> > inside snapshot.c.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Cc: Nigel Cunningham <ncunningham@crca.org.au>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> 
> Seems ok. ACK.

Yes, it looks good.

Rafael
