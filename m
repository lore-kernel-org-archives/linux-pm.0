From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: forcedeth 10de:0373 doesn't work on resume
Date: Mon, 18 Aug 2008 23:42:31 +0200
Message-ID: <200808182342.32039.rjw__49257.7829667882$1219095814$gmane$org@sisk.pl>
References: <4898AA28.8000507@simon.arlott.org.uk>
	<48A9E8B3.4040800@simon.arlott.org.uk>
	<86802c440808181434q2c3b20fcs197c52c51717e782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <86802c440808181434q2c3b20fcs197c52c51717e782@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Simon Arlott <simon@fire.lp0.eu>, linux-kernel@vger.kernel.org, jgarzik@redhat.com, netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, ranma+kernel@tdiedrich.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, 18 of August 2008, Yinghai Lu wrote:
> On Mon, Aug 18, 2008 at 2:25 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
> > On 18/08/08 22:13, Rafael J. Wysocki wrote:
> >
> >>> Is it still broken in current kernels?
> >>
> >> It probably is.
> >
> > If I have MSI enabled, it still doesn't work.
> 
> same problem with nv_shutdown about setting it to D3Hot?

Well, maybe.  The only way to verify that would be to try with MSI
disabled. ;-)

Thanks,
Rafael
