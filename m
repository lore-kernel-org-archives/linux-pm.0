From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Info on hibernation swap space requirement
Date: Wed, 19 Nov 2008 07:47:22 +1100
Message-ID: <1227041242.2723.6.camel@nigel-laptop>
References: <492283F2.1080000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <492283F2.1080000@st.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Francesco VIRLINZI <francesco.virlinzi@st.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Francesco.

On Tue, 2008-11-18 at 09:59 +0100, Francesco VIRLINZI wrote:
> Hi all.
> 
> I added the hibernation support on a sh4 based platform and it works fine,
>  but I don't understand how big the swap space has to be.
> 
> My system has 64Mb and I was assuming, I can freeze ~32 Mb therefore
>  I was creating a swap space of 40/50 Mb.
> 
> But it seems it isn't enough, the system is requiring more space.
> 
> Could you say me how evaluate the right (minimal) swap space required
>  when I know the DRam memory size.

If there's too much memory in use when hibernation is attempted, an
attempt will be made to free memory, which could involve pushing some
pages out to swap. You therefore probably want swap space to be at least
as big as the amount of memory you have, unless you're using the image
compression support that I think uswsusp has.

Please don't forget to post your code - we can then incorporate it in
vanilla and you won't have to worry about keeping it updated.

Nigel
