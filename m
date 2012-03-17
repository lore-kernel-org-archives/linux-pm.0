From: Colin Cross <ccross@android.com>
Subject: Re: [PATCHv2 3/5] cpuidle: add support for states that
 affect multiple cpus
Date: Sat, 17 Mar 2012 12:21:34 -0700
Message-ID: <CAMbhsRQDdXcKVp-_RNe-0i7YYLr4vKDDXqVw_eP4VsmfbFNtYg@mail.gmail.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
	<1331749794-8056-4-git-send-email-ccross@android.com>
	<4F6483BA.8050103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F6483BA.8050103@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 17, 2012 at 5:29 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:

<snip>

> While playing around with this version, I noticed that the
> 'alive_count' is ever incrementing which will lead to
> coupled idle state not being attempted after one CPU offline
> attempt.
>
> Fix in end of the email for the same. With it, coupled states
> continue to work with CPU online/offline transitions.
>
> Feel free to fold it into original patch. Attached
> the same in case mailer eat tabs.

<snip>

Thanks, Kevin reported this issue and I'll fix it in the next version.
