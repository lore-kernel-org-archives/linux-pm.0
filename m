From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: what the patches do Re: [RFC 10/15] PM / Hibernate:
 user, implement user_ops reader
Date: Thu, 25 Mar 2010 17:12:37 +1100
Message-ID: <4BAAFED5.6070501__28008.1160286956$1269497677$gmane$org@crca.org.au>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>	<1269361063-3341-10-git-send-email-jslaby@suse.cz>	<20100325053003.GB12935@elf.ucw.cz>
	<4BAAF7DA.30506@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BAAF7DA.30506@crca.org.au>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi again.

On 25/03/10 16:42, Nigel Cunningham wrote:
> On 25/03/10 16:30, Pavel Machek wrote:
> [...]
>
>> I have some problems with sws_module_ops interface (handcoded locking
>> is too ugly to live), but it is better than I expected. But there may
>> be better solution available, one that does not need two interfaces to
>> maintain (we can't really get rid of userland interface). What about
>> this?
>
> Just picking up on that bracketed part: Can we flag the userland
> interface (and uswsusp) as being planned for eventual removal now... or
> at least agree to work toward that?
>
> I'm asking because if we're going to make a go of getting the in-kernel
> code in much better shape, and we have Rafael, Jiri and I - and you? -
> all pulling in the same direction to improve it, there's going to come a

I realised after sending this that the " - and you? - " was ambiguous. I 
wasn't meaning to suggest that you might pull in a different direction, 
but rather uncertainty as to whether you might help with the effort - 
it's been a while (AFAIR) since you've done any hibernaton patches.

Humble apologies for the ambiguity!

Nigel
