From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCHv2 3/5] cpuidle: add support for states that
 affect multiple cpus
Date: Thu, 15 Mar 2012 18:52:05 -0700
Message-ID: <4F629CC5.60402@linux.intel.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
	<1331749794-8056-4-git-send-email-ccross@android.com>
	<87lin18l7o.fsf@ti.com>
	<CAMbhsRS3J2vruru8i4r1-cB9aJLYW9y1bP0vv7=L3q1JP77ttg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMbhsRS3J2vruru8i4r1-cB9aJLYW9y1bP0vv7=L3q1JP77ttg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 3/15/2012 5:20 PM, Colin Cross wrote:
> Oops, dropped the atomic_dec when I merged from two separate functions
> for up and down to a single function that takes a bool.

generally in Linux we tend to not like "multiplexer" common functions
like this.

my suggestion: make your current function a __ prefixed one, then
provide 2 small inlines that call the __ one...
