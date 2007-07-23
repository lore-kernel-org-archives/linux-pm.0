From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Power Management framework proposal
Date: Mon, 23 Jul 2007 13:29:24 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429017D754B@dlee13.ent.ti.com>
References: <Pine.LNX.4.64.0707212339550.6350@asgard.lang.hm><1185091022.19678.28.camel@localhost.localdomain><Pine.LNX.4.64.0707220057210.6350@asgard.lang.hm><1185105911.29238.43.camel@localhost.localdomain><Pine.LNX.4.64.0707221156210.6350@asgard.lang.hm><1185145766.2714.27.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0707221914550.6350@asgard.lang.hm><1185162647.2714.35.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0707222054060.6350@asgard.lang.hm>
	<1185164357.2714.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <1185164357.2714.49.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>, david@lang.hm
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > this seems to be contradicted by the fact that AMD is listing the
> ability
> > for each core to run at a different clock speed on the new 4-core chips
> as
> > an advantage.
> 
> that's a marketing thing mostly.. they all still run at the same voltage
> anyway.

Several months back I recall seeing in several places that AMD's near term roadmap had each processor in its own voltage plane.  This was contrast to Intel which had it much further out.  As I recall the speculated reason was the silicon process Intel was using allowed them to put off that complexity longer.

http://www.eetimes.com/showArticle.jhtml;jsessionid=WE1VYQTG2ZE5YQSNDLOSKHSCJUNN2JVN?articleID=196604387

http://www.eetimes.com/showArticle.jhtml;jsessionid=WE1VYQTG2ZE5YQSNDLOSKHSCJUNN2JVN?articleID=199700463

Today TI has chips with multiple variable voltage planes so seeing the same out of a company like AMD is not so hard to believe.

Regards,
Richard W.
