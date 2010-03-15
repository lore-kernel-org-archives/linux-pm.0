From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] e1000e / PCI / PM: Add basic runtime PM
	support (rev. 4)
Date: Mon, 15 Mar 2010 20:28:41 +0100
Message-ID: <201003152028.41953.rjw@sisk.pl>
References: <201003150131.59619.rjw@sisk.pl> <201003150135.17564.rjw@sisk.pl>
	<20100315114117.GA1764@qp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100315114117.GA1764@qp>
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

On Monday 15 March 2010, Matthias-Christian Ott wrote:
> On Mon, Mar 15, 2010 at 01:35:17AM +0100, Rafael J. Wysocki wrote:
> > +static bool e1000e_pm_ready(struct e1000_adapter *adapter)
> > +{
> > +	return !!adapter->tx_ring->buffer_info;
> > +}
> 
> Are your sure the double negation is right?

Yes, the function should return true if the pointer is not NULL.  It would work
without the !!, but I used it because of the types mismatch.

Rafael
