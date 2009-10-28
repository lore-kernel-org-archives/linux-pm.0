From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] PM / Hibernate: add \n to load_image
	fail path
Date: Wed, 28 Oct 2009 23:08:17 +0100
Message-ID: <200910282308.17595.rjw__44808.3355477594$1256767907$gmane$org@sisk.pl>
References: <4AD39FBA.6000509@gmail.com>
	<1255383530-6778-1-git-send-email-jirislaby@gmail.com>
	<20091013072841.GD18997@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091013072841.GD18997@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 13 October 2009, Pavel Machek wrote:
> On Mon 2009-10-12 23:38:50, Jiri Slaby wrote:
> > Finish a line by \n when load_image fails in the middle of loading.
> > 
> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ACK.

Applied to suspend-2.6/linux-next.

Thanks,
Rafael
