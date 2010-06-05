From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [SUSPECTED SPAM] Re: Proposal for a new algorithm
 for	reading & writing a hibernation image.
Date: Sat, 05 Jun 2010 10:20:55 +1000
Message-ID: <4C099867.4050807__8685.38451982222$1275697304$gmane$org@crca.org.au>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi again.

As I think about this more, I reckon we could run into problems at 
resume time with reloading the image. Even if some bits aren't modified 
as we're writing the image, they still might need to be atomically 
restored. If we make the atomic restore part too small, we might not be 
able to do that.

So perhaps the best thing would be to stick with the way TuxOnIce splits 
the image at the moment (page cache / process pages vs 'rest'), but 
using this faulting mechanism to ensure we do get all the pages that are 
changed while writing the first part of the image.

Regards,

Nigel
