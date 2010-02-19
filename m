From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [PATCH 1/1] PM / Hibernate: remove swsusp.c
Date: Sat, 20 Feb 2010 10:04:57 +1100
Message-ID: <4B7F1919.2010605__34763.2730067291$1266620602$gmane$org@tuxonice.net>
References: <1266620017-11061-1-git-send-email-jslaby@suse.cz>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1266620017-11061-1-git-send-email-jslaby@suse.cz>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi.

Jiri Slaby wrote:
> Its contents and entry in Makefile were already removed in
> 8e60c6a1348e17e68ad73589a52a03876e7059be
> (Shift remaining code from swsusp.c to hibernate.c)
> but somehow it remained in-place.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <nigel@tuxonice.net>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>

Yeah. The version that was actually committed was different to the patch
I sent.

Acked-by: Nigel Cunningham <nigel@tuxonice.net>
