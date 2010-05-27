From: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH-v2 3/8] cpuidle: make cpuidle_curr_driver
	static
Date: Thu, 27 May 2010 11:40:41 -0700
Message-ID: <987664A83D2D224EAE907B061CE93D5301135014D2__5112.85670004344$1275063814$gmane$org@orsmsx505.amr.corp.intel.com>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<db2b1d371847edfdbba21f323b4fd4a480c8c5aa.1274926772.git.len.brown@intel.com>
	<alpine.LFD.2.00.1005270126000.4039@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005270126000.4039@localhost.localdomain>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

+static inline cpuidle_driver *cpuidle_get_driver(void) {return NULL;}

Close, but no cigar yet. You missed a "struct" keyword on this line.
Add that, and it builds and boots for me.

-Tony
