From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 00/10] mm: Linux VM Infrastructure to support
 Memory Power Management
Date: Mon, 13 Jun 2011 07:28:50 -0700
Message-ID: <20110613072850.7234462b__4269.34046340666$1307975170$gmane$org@infradead.org>
References: <20110610171939.GE2230@linux.vnet.ibm.com>
	<20110610172307.GA27630@srcf.ucam.org>
	<20110610175248.GF2230@linux.vnet.ibm.com>
	<20110610180807.GB28500@srcf.ucam.org>
	<20110610184738.GG2230@linux.vnet.ibm.com>
	<20110610192329.GA30496@srcf.ucam.org>
	<20110610193713.GJ2230@linux.vnet.ibm.com>
	<20110610200233.5ddd5a31@infradead.org>
	<20110611170610.GA2212@linux.vnet.ibm.com>
	<20110611102654.01e5cea9@infradead.org>
	<20110612230707.GE2212@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110612230707.GE2212@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: Kyungmin Park <kmpark@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, thomas.abraham@linaro.org, Ankita Garg <ankita@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, 12 Jun 2011 16:07:07 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > 
> > the codec issue seems to be solved in time; a previous generation
> > silicon on our (Intel) side had ARM ecosystem blocks that did not do
> > scatter gather, however the current generation ARM ecosystem blocks
> > all seem to have added S/G to them....
> > (in part this is coming from the strong desire to get camera/etc
> > blocks to all use "GPU texture" class memory, so that the camera
> > can directly deposit its information into a gpu texture, and
> > similar for media encode/decode blocks... this avoids copies as
> > well as duplicate memory).
> 
> That is indeed a clever approach!
> 
> Of course, if the GPU textures are in main memory, there will still
> be memory consumption gains to be had as the image size varies (e.g.,
> displaying image on one hand vs. menus and UI on the other). 

graphics drivers and the whole graphics stack is set up to deal with
that... textures aren't per se "screen size", the texture for a button
is only as large as the button (with some rounding up to multiples of
some small power of two) 




-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
