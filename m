From: Alex Goebel <alex.goebel@gmail.com>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 7 May 2009 17:11:05 -0700
Message-ID: <faa09fad0905071711v788e847dr33cf5a2eb688c1cc__25450.4280085259$1241797167$gmane$org@mail.gmail.com>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<20090507120948.GA1531@ucw.cz> <4A03129A.90105@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A03129A.90105@acm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: U Kuehn <ukuehn@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

> Given that tuxonice DOES work reliably with dm-crypt encrypted swap
> partitions, does uswsusp offer this functionality? Looking into the docs
> on the sourceforge site does not give any information about this point.

Works here. Just tried (s2disk, vanilla 2.6.29). It also claims you
can hit "Del" to abort and to that it compressed the image.

Alex
