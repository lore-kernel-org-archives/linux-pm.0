From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?utf-8?q?=5BSUSPECTED_SPAM=5D_Re=3A_Proposal_for_a_ne?=
 =?utf-8?q?w_algorithm_for=09reading_=26_writing_a_hibernation_image=2E?=
Date: Sat, 5 Jun 2010 20:45:19 +0200
Message-ID: <201006052045.19889.rjw__28972.1843706959$1275763527$gmane$org@sisk.pl>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<4C099867.4050807@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C099867.4050807@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Saturday 05 June 2010, Nigel Cunningham wrote:
> Hi again.
> 
> As I think about this more, I reckon we could run into problems at 
> resume time with reloading the image. Even if some bits aren't modified 
> as we're writing the image, they still might need to be atomically 
> restored. If we make the atomic restore part too small, we might not be 
> able to do that.
> 
> So perhaps the best thing would be to stick with the way TuxOnIce splits 
> the image at the moment (page cache / process pages vs 'rest'), but 
> using this faulting mechanism to ensure we do get all the pages that are 
> changed while writing the first part of the image.

I still don't quite understand why you insist on saving the page cache data
upfront and re-using the memory occupied by them for another purpose.  If you
dropped that requirement, I'd really have much less of a problem with the
TuxOnIce's approach.

Rafael
