From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
 driver for select intel processors
Date: Thu, 27 May 2010 20:14:39 -0700
Message-ID: <20100527201439.6d0fd169__23705.4806588732$1275016422$gmane$org@infradead.org>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<e099975ca65a7f6ac7f8bc3fee84d3e03893aa31.1274926772.git.len.brown@intel.com>
	<198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
	<87ljb5l9d5.fsf@deeprootsystems.com>
	<20100527072207.2e783b1e@infradead.org> <4BFE86D4.60602@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BFE86D4.60602@nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: "Len@smtp1.linux-foundation.org" <Len@smtp1.linux-foundation.org>, Brown <len.brown@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 May 2010 17:51:00 +0300
Igor Stoppa <igor.stoppa@nokia.com> wrote:

> Hi,
> 
> 
> ext Arjan van de Ven wrote:
> 
> > it's really inconvenient to have such drivers hidden in the
> > architecture code; it's much more convenient for cpuidle developers
> > if they're all in one place.
> >   
> 
> why?

because you have all the users of your API in one place.
