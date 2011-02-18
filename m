From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PM QoS: Allow parsing of ASCII values
Date: Fri, 18 Feb 2011 15:39:56 +0900
Message-ID: <20110218063955.GA2558@verge.net.au>
References: <1297994096-1839-1-git-send-email-horms@verge.net.au>
	<20110218050516.GA5813@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110218050516.GA5813@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <markgross@thegnar.org>
Cc: linux-pm@lists.linux-foundation.org, Dan Carpenter <error27@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On Thu, Feb 17, 2011 at 09:05:16PM -0800, mark gross wrote:
> On Fri, Feb 18, 2011 at 10:54:56AM +0900, Simon Horman wrote:
> > In "PM QoS: Correct pr_debug() misuse and improve parameter checks"
> > the parsing of the ASCII hex value was tightened. Unfortunately
> > it was tightened to the point where no value is valid.
> 
> How is it of no value?  Can you not sent a 10 char string with a
> zero-byte end of string maker?

My testing indicates that

echo -n "0x12345678" will yield count == 10 in copy_from_user()

that

echo "0x12345678" will yield count == 11 in copy_from_user()

and that in both case strlen() will yeild the same value as count.

> Is expecting the c-string marker in the interface a bad idea that needs
> fixing?

I think that is the crux of the problem from my point of view.
That is, using echo as above there is no '\0' by the time
the string gets to the kernel.

I now see that the following works :-)

echo -ne '0x12345678\0' | dd of=/dev/network_latency

However I wonder if the call to strlen() is safe.
In the case of the following is there any guarantee that
ascii_value is '\0' terminated? Perhaps strnlen() is needed?

echo -n '0x123456789' | dd of=/dev/network_latency

> > Root of the problem seems to lie in wheather the ASCII hex is followed
> > by a '\n' or not. My reading of the documentation is that the '\n' should
> > not be present. However the code previously only accepted that version.
> > The current code accepts neither. My fix is to accept both.
> 
> The documentation says it should be a 10byte string.
> "Alternatively the user mode program could write a hex string for the
> value using 10 char long format e.g. "0x12345678".  This translates to a
> pm_qos_update_request call."
> 
> When I wrote the code I was thinking that a c-string that has a zero
> byte end of string maker.  note: a new line character is not implied
> anywhere.
> 
> However; reading the documentation it is somewhat ambiguous the buffer
> is 10 bytes or 11.
> 
> We should tighten up the Documentation and make the code match it.
> 
> I don't like the 10 or 11 byte buffer logic.  It should be one or the
> other and not include any new line character.
> 
> What do you want the documentation to read?

I would describe the format as

"Alternatively the user mode program could write a hex string for the
value using 11 char long format e.g. "0x12345678\0". Note that the trailing
'\0' needs to be included in the write to the device."

Because to me the existing description implies

	str = "0x12345678";
	write(fd, str, srlen(str));

But the correct code is

	str = "0x12345678";
	write(fd, str, srlen(str) + 1);

To be honest I think that the first code-snippet is more in keeping with
typical C string usage. But to change the code to only accept that would
break compatibility.
