From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: 3.3.5 regression: resume doesn't switch to X
Date: Sun, 13 May 2012 21:57:34 +0200
Message-ID: <4FB0122E.4000603@suse.cz>
References: <4FAE0E88.2030703@suse.cz> <20120512154307.GA6023@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120512154307.GA6023@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, alexander.deucher@amd.com, "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 05/12/2012 05:43 PM, Greg KH wrote:
> On Sat, May 12, 2012 at 09:17:28AM +0200, Jiri Slaby wrote:
>> Hi,
> 
> <side note, it's stable@vger.kernel.org, not stable@kernel.org>

Ah, fixed. Why it didn't bounce? Is it silently dropped?

>> since update to 3.3.5, my X doesn't show up after resume from
>> hibernation anymore. The only thing I see is "resuming..." on the
>> console. I can switch to any tty and login in text mode, but cannot
>> switch to X despite it is running. I have to restart whole session to
>> have X again.
>>
>> Now I'm back to 3.3.4 and everything is OK.
> 
> Care to run 'git bisect' to find the offending patch?

Hmm, I cannot reproduce. I booted 3.3.5 twice and X did not show up
after resume. Then I booted 3.3.4 and it worked. Now 3.3.5 works too...
So maybe this is uptime related or I hit some race twice in a row?

Anyway now I'm running 3.3.5 and the problem have not recurred yet...

thanks,
-- 
js
suse labs
