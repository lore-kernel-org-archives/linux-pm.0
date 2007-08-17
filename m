From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] x86_64: Save registers in saved_context
	during suspend and hibernation
Date: Sat, 18 Aug 2007 00:09:33 +0200
Message-ID: <200708180009.34482.rjw__9561.79349818758$1187388033$gmane$org@sisk.pl>
References: <200708171526.23250.rjw@sisk.pl>
	<20070817140820.63c22071.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070817140820.63c22071.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 17 August 2007 23:08, Andrew Morton wrote:
> On Fri, 17 Aug 2007 15:26:22 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > During hibernation and suspend on x86_64 save CPU registers in the saved_context
> > structure rather than in a handful of separate variables.
> 
> You have "-mm" in the subject but afaict this patch is not dependent upon
> anything in -mm?

It shouldn't be.  The -mm means that I regard it as -mm material.
