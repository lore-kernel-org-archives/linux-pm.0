From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: wait_for_completion_interruptible does not wait !!
 [During PM suspend]
Date: Sun, 20 Jun 2010 09:51:31 +0200
Message-ID: <4C1DC883.7090009__48585.662051528$1277020337$gmane$org@gmail.com>
References: <AANLkTik5x38mWno0EUGhaHDD_INLlpeaGSExGxjIC4as@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik5x38mWno0EUGhaHDD_INLlpeaGSExGxjIC4as@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 06/20/2010 09:42 AM, Suresh Rajashekara wrote:
> On Sun, Jun 20, 2010 at 12:23 AM, Jiri Slaby <jirislaby@gmail.com> wrote:
>> On 06/20/2010 08:52 AM, Suresh Rajashekara wrote:
>>> The ioctl waits on a completion variable (using
>>> wait_for_completion_interruptible).
>> ...
>>> I tried wait_for_completion instead, but now the kernel refuses to suspend.
>>
>> Do you check return value of wait_for_completion_interruptible and
>> return its value if nonzero?
>>
>> We need the code to comment, otherwise it's hard to say.
> 
> No. I am not checking the return value of the
> wait_for_completion_interruptible. I can do it

I thought so. Generally, all *_interruptible functions return a value
which should be checked and propagated to upper layers.

-- 
js
