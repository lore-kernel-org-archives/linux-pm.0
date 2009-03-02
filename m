From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Very rare resume bug
Date: Mon, 02 Mar 2009 02:05:18 +0200
Message-ID: <1235952318.430.3.camel@maxim-laptop>
References: <1235912755.7665.4.camel@localhost>
	<200903012221.12423.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903012221.12423.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-03-01 at 22:21 +0100, Rafael J. Wysocki wrote:
> On Sunday 01 March 2009, Maxim Levitsky wrote:
> > I currently am testing suspend/resume on my desktop system.
> > I already kept it in suspend to ram state in 2 weeks, and now
> > I resumed it, and screen didn't came back, I tried switching vts
> > it did seem to help, but then everything hung.
> 
> Well, it's difficult to say what problem this is.


I thought that warning that I have seen in the logs is the reason for
this hang as it was vt related.
I have seen patches here that fix very related bug.
I continue this test by only using S2RAM on that system about 4~5 times
a day.

Best regards,
	Maxim Levitsky
