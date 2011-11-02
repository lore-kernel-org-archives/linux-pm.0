From: Andrew Watts <akwatts@ymail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Tue, 1 Nov 2011 19:24:44 -0500
Message-ID: <20111102002442.GA4793__47249.867875553$1320296228$gmane$org@zeus>
References: <20111101124759.GA1326@zeus> <20111101164235.GS18855@google.com>
	<20111101191459.GA2748@zeus> <20111101201902.GA1763@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111101201902.GA1763@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 01, 2011 at 01:19:02PM -0700, Tejun Heo wrote:
> 
> Odd... how about the following one?  Thanks.
> 

No, the 2nd patch doesn't work either. However, as I mentioned, reversing 
8ee294cd9def000 (and part of 1d64b655dc083df) does fix it.

~ Andy

PS I noticed your posts make it to linux-pm@lists.linux-foundation.org.
   Mine never arrive there. Is that list closed?
