From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/2] PM: Add support for device power
	domains
Date: Mon, 14 Feb 2011 22:01:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102142158100.17345-100000__42057.4595140808$1297743231$gmane$org@netrider.rowland.org>
References: <201102142334.47553.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102142334.47553.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Feb 2011, Rafael J. Wysocki wrote:

> > I don't have a clear picture of how people are going to want to use 
> > these dev_power_domain structures.  Should there be a
> > 
> > 	void			*priv;
> > 
> > member as well?
> 
> Well, I'm not sure.  What would be the purpose of it?

It's easy to imagine an SoC with multiple power domains and hence
multiple structures.  The platform code would need some way to tell
those structures apart.  But we should get some advice from the people
who will actually have to use these things...

Alan Stern
