From: "Bhattacharya, Rishi" <rishi@ti.com>
Subject: RE: Power Management framework proposal
Date: Mon, 23 Jul 2007 14:45:47 -0500
Message-ID: <5232854749CF42409252DEA811C09FF101B0999F@dlee10.ent.ti.com>
References: <200707231908.l6NJ8XA2018304@smtp2.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200707231908.l6NJ8XA2018304@smtp2.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> I'm the last person to know details of unreleased AMD features
(working
> for Intel and all that) but all the things I've read so far suggest
only
> the memory controller will have it's own voltage plane, but that the
two
> cores still share the same plane.

What you described is in fact true for AMD's upcoming "Phenom" platform.
However, the "Griffin" architecture that follows will allow for three
voltage planes (for dual-core platforms) - one for each core, and
another for Northbridge (memory).  AnandTech does a great job (as
always) of describing this:  

http://www.anandtech.com/printarticle.aspx?i=2992

Take care,

Rishi
