From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [Q] APM depends on PM_SLEEP?
Date: Fri, 5 Oct 2007 18:27:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0710051827020.10392@poirot.grange>
References: <Pine.LNX.4.60.0710051615350.10392@poirot.grange>
	<200710051749.52685.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710051749.52685.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Oct 2007, Rafael J. Wysocki wrote:

> On Friday, 5 October 2007 16:18, Guennadi Liakhovetski wrote:
> > Why does APM depend on PM_SLEEP?
> 
> Because APM uses the suspend core functions in drivers/base/power .

Ok, perhaps, a "select" would be better?...

Thanks
Guennadi
---
Guennadi Liakhovetski
