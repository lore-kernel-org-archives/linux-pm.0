From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
 for	reading & writing a hibernation image.
Date: Sat, 05 Jun 2010 22:10:21 +0300
Message-ID: <1275765021.12828.2.camel__46773.2891942889$1275765180$gmane$org@maxim-laptop>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<4C099867.4050807@crca.org.au>  <201006052045.19889.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006052045.19889.rjw@sisk.pl>
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
Cc: TuxOnIce-devel <tuxonice-devel@tuxonice.net>, Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-06-05 at 20:45 +0200, Rafael J. Wysocki wrote: 
> On Saturday 05 June 2010, Nigel Cunningham wrote:
> > Hi again.
> > 
> > As I think about this more, I reckon we could run into problems at 
> > resume time with reloading the image. Even if some bits aren't modified 
> > as we're writing the image, they still might need to be atomically 
> > restored. If we make the atomic restore part too small, we might not be 
> > able to do that.
> > 
> > So perhaps the best thing would be to stick with the way TuxOnIce splits 
> > the image at the moment (page cache / process pages vs 'rest'), but 
> > using this faulting mechanism to ensure we do get all the pages that are 
> > changed while writing the first part of the image.
> 
> I still don't quite understand why you insist on saving the page cache data
> upfront and re-using the memory occupied by them for another purpose.  If you
> dropped that requirement, I'd really have much less of a problem with the
> TuxOnIce's approach.
Because its the biggest advantage?
Really saving whole memory makes huge difference.


Best regards,
Maxim Levitsky
