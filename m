From: David Miller <davem@davemloft.net>
Subject: Re: 3.3.5 regression: resume doesn't switch to X
Date: Sun, 13 May 2012 16:08:41 -0400 (EDT)
Message-ID: <20120513.160841.2185362023230844444.davem@davemloft.net>
References: <4FAE0E88.2030703@suse.cz> <20120512154307.GA6023@kroah.com>
	<4FB0122E.4000603@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FB0122E.4000603@suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: jslaby@suse.cz
Cc: jirislaby@gmail.com, greg@kroah.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, alexander.deucher@amd.com, sedat.dilek@gmail.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>
Date: Sun, 13 May 2012 21:57:34 +0200

> On 05/12/2012 05:43 PM, Greg KH wrote:
>> On Sat, May 12, 2012 at 09:17:28AM +0200, Jiri Slaby wrote:
>>> Hi,
>> 
>> <side note, it's stable@vger.kernel.org, not stable@kernel.org>
> 
> Ah, fixed. Why it didn't bounce? Is it silently dropped?

vger.kernel.org kills it because it looks like SPAM or a looping
posting since it has Delivered-To: header fields in it when the
copy comes from stable@kernel.org

The kernel.org folks needs to really just take that email alias
down and turn it off, nothing from it makes the list for almost
a year now.  It's completely pointless.
