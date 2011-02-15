From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2] PM: Add support for device power
	domains
Date: Tue, 15 Feb 2011 22:40:02 +0100
Message-ID: <201102152240.03077.rjw__28294.1371937797$1297874938$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1102142158100.17345-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102142158100.17345-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 15, 2011, Alan Stern wrote:
> On Mon, 14 Feb 2011, Rafael J. Wysocki wrote:
> 
> > > I don't have a clear picture of how people are going to want to use 
> > > these dev_power_domain structures.  Should there be a
> > > 
> > > 	void			*priv;
> > > 
> > > member as well?
> > 
> > Well, I'm not sure.  What would be the purpose of it?
> 
> It's easy to imagine an SoC with multiple power domains and hence
> multiple structures.  The platform code would need some way to tell
> those structures apart.  But we should get some advice from the people
> who will actually have to use these things...

Well, anyway I think it should be easy to add a priv pointer at any time later
if there's a use case?

Rafael
